module Connection
  require 'net/http'
  require 'uri'

  def Connection.is_200?(url)
    begin
      url = URI.parse(url)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.get('/healthcheck')
      }
      res.code == "200"
    rescue
      false
    end
  end
  
  
end