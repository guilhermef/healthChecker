require 'net/http'
require 'uri'

class Connection

  def initialize(url)
    url = URI.parse(url)
    @response = Net::HTTP.start(url.host, url.port) {|http|
      http.get('/')
    }
  end
  
  def status_code
    return @response.code
  end
end