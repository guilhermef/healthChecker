require 'net/http'
require 'uri'

class Connection

  def initialize(url)
    uri = URI.parse(url)
    @response = Net::HTTP.start(uri.host, uri.port) {|http|
      http.get(uri.path)
    }
  end
  
  def status_code
    return @response.code
  end
end