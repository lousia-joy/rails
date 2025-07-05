require "open-uri"

class ProxyController < ApplicationController
  def image
    url = params[:url]
    puts "Fetching image from #{url}"  # ✔️ 这个位置才是对的

    # 防 SSRF（建议白名单更精确）
    unless url =~ /\Ahttps:\/\/scontent-[\w\-\.]+\.cdninstagram\.com/
      return head :forbidden
    end

    begin
      image_data = URI.open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read
      send_data image_data, type: "image/jpeg", disposition: "inline"
    rescue => e
      Rails.logger.error "Image fetch failed: #{e.message}"
      head :bad_request
    end
  end
end
