require 'fakeweb'

FakeWeb.register_uri(:get, "http://www.return.200.com/healthcheck", :body => "I'm alive", :status => ["200", "OK"])
FakeWeb.register_uri(:get, "http://www.return.404.com/healthcheck", :body => "I'm not here", :status => ["404", "Not Found"])
FakeWeb.register_uri(:get, "http://www.return.500.com/healthcheck", :body => "I'm not here", :status => ["500", "Forbidden"])
