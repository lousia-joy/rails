# app/parsers/instagram_json_parser.rb

class InstagramJsonParser
  def self.parse(file_path)
    json = JSON.parse(File.read(file_path))
    json.map do |post|
      Post.new(
        image_url: post["image_url"],
        caption: post["caption"],
        username: post["username"],
        timestamp: post["timestamp"]
      )
    end
  end
end
