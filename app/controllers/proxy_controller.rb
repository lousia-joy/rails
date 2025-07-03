require "open-uri"
puts "Fetching image from #{params[:url]}"
class ProxyController < ApplicationController
  def image
    url = params[:url]

    # 校验，防止 SSRF 攻击（你可以更严格地限制白名单）
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
