class TopicsController < ApplicationController
  def show
    topic_name = params[:id]
    safe_id = File.basename(topic_name.to_s.gsub(/[^0-9a-z_]/i, ""))
    file_path = Rails.root.join("data", "instagram_#{safe_id}_posts.json")

    raw_posts = File.exist?(file_path) ? InstagramJsonParser.parse(file_path) : []
    puts "————————Parsed posts count: #{raw_posts.length}————————"

    @posts = raw_posts

    @topic = Topic.new(id: 1, name: topic_name)
    @topic.posts = @posts

    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @per_page = 5
    @paginated_posts = @topic.posts.slice((@page - 1) * @per_page, @per_page) || []
  end
end
