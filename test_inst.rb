require 'uri'
require 'net/http'
require 'json'

def fetch_instagram_posts(tag, limit = 5)
  url = URI("https://instagram-looter2.p.rapidapi.com/tag-feeds?query=#{tag}")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-key"] = 'd5ef4466b4msh090f8f80545854ep19e958jsn11c386005166'
  request["x-rapidapi-host"] = 'instagram-looter2.p.rapidapi.com'

  response = http.request(request)

  if response.code == '200'

    # 提取前 N 条结果
    parsed = JSON.parse(response.body)
    posts_array = parsed['data'] || parsed['items'] || parsed.values.find { |v| v.is_a?(Array) }

    limited_data = posts_array&.first(limit) || []

    puts "成功获取 #{tag} 话题的前 #{limit} 条结果:"
    puts JSON.pretty_generate(limited_data)

    limited_data
  else
    puts "API 请求失败: #{response.code} - #{response.message}"
    nil
  end
end

topic = dog
# 测试获取 #cat 话题的前  条内容
posts = fetch_instagram_posts('', 1)
puts posts

# 如果需要保存到文件


if posts
  File.write("instagram_${filename}_posts.json", JSON.pretty_generate(posts))
  puts "结果已保存到 instagram_${filename}_posts.json"
end
