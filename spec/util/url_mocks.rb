require 'fakeweb'

["http://www.return.200.com/healthcheck", "http://www.return2.200.com/healthcheck",
"http://www.return3.200.com/healthcheck"].each do |url|
  FakeWeb.register_uri(:get, url, :body => "I'm alive", :status => ["200", "OK"])
end

FakeWeb.register_uri(:get, "http://www.return.404.com/healthcheck", :body => "I'm not here", :status => ["404", "Not Found"])
FakeWeb.register_uri(:get, "http://www.return.500.com/healthcheck", :body => "I'm not here", :status => ["500", "Forbidden"])
