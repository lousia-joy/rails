require "uri"
require "net/http"
require "json"

class InstagramLooterFetcher
  def self.fetch(topic_name)
    url = URI("https://instagram-looter2.p.rapidapi.com/hashtag/#{topic_name}/medias/top?country=us")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = ENV["RAPIDAPI_KEY"]
    request["x-rapidapi-host"] = "instagram-looter2.p.rapidapi.com"

    response = http.request(request)
    data = JSON.parse(response.read_body)

    data["items"] || []
  rescue StandardError => e
    Rails.logger.error("API fetch failed: #{e.message}")
    []
  end

  def self.search_hashtags(query)
    Rails.cache.fetch("hashtag_search_#{query}", expires_in: 15.minutes) do
      url = URI("https://instagram-looter2.p.rapidapi.com/search?query=#{query}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = ENV["RAPIDAPI_KEY"]
      request["x-rapidapi-host"] = "instagram-looter2.p.rapidapi.com"

      response = http.request(request)
      data = JSON.parse(response.read_body)
      data["hashtags"] || []
      rescue StandardError => e
      Rails.logger.error("Hashtag search failed: #{e.message}")
      []
    end
  end
end
