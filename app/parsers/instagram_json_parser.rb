require "json"
require "time"

class InstagramJsonParser
  def self.parse(file_path)
    raw = JSON.parse(File.read(file_path))
    data_hash = raw.find { |pair| pair.first == "data" }&.last
    edges = data_hash.dig("hashtag", "edge_hashtag_to_media", "edges") || []

    edges.map do |edge|
      node = edge["node"]
      {
        caption: node.dig("edge_media_to_caption", "edges", 0, "node", "text"),
        username: node.dig("owner", "id"),
        image_url: node["display_url"],
        timestamp: node["taken_at_timestamp"]
      }
    end
  end
end
