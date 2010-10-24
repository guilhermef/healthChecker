require 'spec/spec_helper'
require 'connection'

describe Connection, "#status" do
 
  it "returns '200' for a alive service" do
    response = Connection.new("http://www.return.200.com/healthcheck")
    response.status_code.should == '200'
  end

  it "returns '404' for a service not found" do
    response = Connection.new("http://www.return.404.com/healthcheck")
    response.status_code.should == '404'
  end

  it "returns '500' for a forbidden service" do
    response = Connection.new("http://www.return.500.com/healthcheck")
    response.status_code.should == '500'
  end
  
end
