module Connection
  require 'net/http'
  require 'uri'

  def Connection.is_200?(url)
    url = URI.parse(url)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.get('/healthcheck')
    }
    res.code == "200"
  end
  
  
end