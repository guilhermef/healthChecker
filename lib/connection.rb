require 'net/http'
require 'uri'

class Connection
  attr_accessor :status_code

  def initialize(url)
    uri = URI.parse(url)
    begin
      response = Net::HTTP.start(uri.host, uri.port) {|http|
        http.get(uri.path)
      }
      status = response.code
    rescue SocketError
      status = '404'
    ensure
      @status_code = status
    end
  end

end