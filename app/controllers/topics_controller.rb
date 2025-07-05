class TopicsController < ApplicationController
  def show
    topic_name = params[:id]
    safe_id = File.basename(topic_name.to_s.gsub(/[^0-9a-z_]/i, ""))
    file_path = Rails.root.join("data", "instagram_#{safe_id}_posts.json")

    # 读取本地 JSON 文件数据
    raw_posts = File.exist?(file_path) ? InstagramJsonParser.parse(file_path) : []
    puts "———Parsed posts count: #{raw_posts.length}———"

    @posts = raw_posts

    @topic = Topic.new(id: 1, name: topic_name)
    @topic.posts = @posts

    # 分页逻辑
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @per_page = 5
    @paginated_posts = @topic.posts.slice((@page - 1) * @per_page, @per_page) || []

    # WebSocket 广播逻辑（仅示例：如果传参中含有 broadcast=true，就推送给订阅者）
    if params[:broadcast] == "true"
      ActionCable.server.broadcast(
        "topic_channel_#{topic_name}",
        {
          posts: @paginated_posts.map do |post|
            {
              image_url: post.image_url,
              username: post.username,
              caption: post.caption,
              timestamp: post.timestamp
            }
          end
        }
      )
    end
  end

  def broadcast_fake_post
    topic_id = params[:id].to_s
    topic = Topic[topic_id]
    return head :not_found unless topic

    post = Post.new(
      id: SecureRandom.uuid,
      username: "TestUser AAAAA",
      caption: "这是一条来自 WebSocket 的测试帖子",
      image_url: "https://www.nipic.com/show/42901846.html", # 替换成真实可访问图片
      timestamp: Time.current,
      topic: topic
    )

    Turbo::StreamsChannel.broadcast_append_to(
    "topic_#{params[:id]}",
    target: "posts",
    partial: "posts/post",
    locals: { post: post }
  )

    head :ok
  end
end
