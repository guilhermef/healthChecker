require 'connection'
require 'fakeweb'

describe Connection, "#status" do
  FakeWeb.register_uri(:get, "http://www.return.200.com", :body => "I'm alive", :status => ["200", "OK"])
  FakeWeb.register_uri(:get, "http://www.return.404.com", :body => "I'm not here", :status => ["404", "Not Found"])
  FakeWeb.register_uri(:get, "http://www.return.500.com", :body => "I'm not here", :status => ["500", "Forbidden"])
  
 
  it "returns '200' for a alive service" do
    response = Connection.new("http://www.return.200.com")
    response.status_code.should == '200'
  end

  it "returns '404' for a service not found" do
    response = Connection.new("http://www.return.404.com")
    response.status_code.should == '404'
  end

  it "returns '500' for a forbidden service" do
    response = Connection.new("http://www.return.500.com")
    response.status_code.should == '500'
  end
  
end
