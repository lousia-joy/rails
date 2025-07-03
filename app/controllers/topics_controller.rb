class TopicsController < ApplicationController
  def show
    topic_name = params[:id]
    # 转成字符串，用正则表达式移除不安全字符，再读取预设json文件
    safe_id = File.basename(params[:id].to_s.gsub(/[^0-9a-z_]/i, ""))
    file_path = Rails.root.join("lib", "data", "instagram_#{safe_id}_posts.json")
    raw_posts = File.exist?(file_path) ? InstagramJsonParser.parse(file_path) : []

    @topic = Topic.new(id: 1, name: topic_name)
    @topic.posts = raw_posts
    # raw_posts = InstagramLooterFetcher.fetch(topic_name) # 仅使用 fetch 方法

    # @topic = Topic.new(id: 1, name: topic_name)
    # @topic.posts = raw_posts.map do |p|
    #   Post.new(
    #     image_url: p["image_url"],
    #     caption: p["caption"],
    #     username: p["username"],
    #     timestamp: p["timestamp"]
    #   )
    # end

    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @per_page = 5
    @paginated_posts = @topic.posts.slice((@page - 1) * @per_page, @per_page) || []
  end
end
