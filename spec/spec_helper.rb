$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'fakeweb'


RSpec.configure do |c|
  c.filter_run :focus => true
  c.run_all_when_everything_filtered = true
end

FakeWeb.register_uri(:get, "http://www.return.200.com/healthcheck", :body => "I'm alive", :status => ["200", "OK"])
FakeWeb.register_uri(:get, "http://www.return.404.com/healthcheck", :body => "I'm not here", :status => ["404", "Not Found"])
FakeWeb.register_uri(:get, "http://www.return.500.com/healthcheck", :body => "I'm not here", :status => ["500", "Forbidden"])
