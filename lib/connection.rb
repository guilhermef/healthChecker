require 'net/http'
require 'uri'

class Connection
  attr_accessor :status_code

  def initialize(url)
    uri = URI(url)
    begin
      status = Net::HTTP.get_response(uri).code
    rescue SocketError
      status = '404'
    ensure
      @status_code = status
    end
  end

end