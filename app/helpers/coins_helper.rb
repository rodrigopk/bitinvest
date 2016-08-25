module CoinsHelper
  #require "net/http"
  #
  # def icon_url(tag)
  #   url = URI.parse("https://coinmarketcap.com/static/img/coins/16x16/"+tag+".png")
  #   req = Net::HTTP.new(url.host, url.port)
  #   req.use_ssl = true
  #   res = req.request_head(url.path)
  #   if res.code == "200"
  #     logger.debug "\n=== return : #{url.host+url.path} ====\n"
  #     return url.to_s
  #   else
  #     return "coin_404_16.png"
  #   end
  # end

  def icon_url(tag)
    "coin_icons/"+tag+".png"
  end

end
