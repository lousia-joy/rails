class Post
  attr_accessor :image_url, :caption, :username, :timestamp

  def initialize(image_url:, caption:, username:, timestamp:)
    @image_url = image_url
    @caption = caption
    @username = username
    @timestamp = timestamp
  end
end
