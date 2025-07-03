require 'uri'
require 'net/http'
require 'json'

def fetch_instagram_posts(tag)
  url = URI("https://instagram-looter2.p.rapidapi.com/tag-feeds?query=#{tag}")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-key"] = 'd5ef4466b4msh090f8f80545854ep19e958jsn11c386005166'
  request["x-rapidapi-host"] = 'instagram-looter2.p.rapidapi.com'

  response = http.request(request)

  if response.code == '200'
    parsed = JSON.parse(response.body)

    puts "✅ 原始 API 返回结构（缩略）："
    puts JSON.pretty_generate(parsed.slice("data")) rescue puts "❗结构不是Hash，实际为：#{parsed.class}"

    # 提取图片/描述等字段（可选）
    posts_array = parsed.dig("data", "hashtag", "edge_hashtag_to_media", "edges") || []
    simplified_posts = posts_array.map do |edge|
      node = edge["node"]
      {
        "image_url" => node.dig("display_url"),
        "caption" => node.dig("edge_media_to_caption", "edges", 0, "node", "text"),
        "username" => node.dig("owner", "id"),
        "timestamp" => Time.at(node["taken_at_timestamp"]).utc.iso8601
      }
    end

    puts "\n✅ 提取成功: #{simplified_posts.size} 条 Post"
    puts JSON.pretty_generate(simplified_posts[0..2])  # 示例显示前3条，避免太长

    # 保存原始返回数据
    File.write("instagram_raw_#{tag}_posts.json", JSON.pretty_generate(parsed))
    puts "\n📦 原始数据已保存为 instagram_raw_#{tag}_posts.json"

    # 保存简化后的数据
    File.write("instagram_#{tag}_posts.json", JSON.pretty_generate(simplified_posts))
    puts "📦 精简数据已保存为 instagram_#{tag}_posts.json"

    simplified_posts
  else
    puts "❌ API 请求失败: #{response.code} - #{response.message}"
    nil
  end
end

# 使用举例：
tag = "funnymemes"
fetch_instagram_posts(tag)
