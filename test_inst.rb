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
    data = JSON.parse(response.body)

    # 提取前 N 条结果
    limited_data = data.first(limit)

    puts "成功获取 #{tag} 话题的前 #{limit} 条结果:"
    puts JSON.pretty_generate(limited_data)

    limited_data
  else
    puts "API 请求失败: #{response.code} - #{response.message}"
    nil
  end
end

# 测试获取 #cat 话题的前 10 条内容
posts = fetch_instagram_posts('cat', 5)

# 如果需要保存到文件
if posts
  File.write("instagram_cat_posts.json", JSON.pretty_generate(posts))
  puts "结果已保存到 instagram_cat_posts.json"
end
