$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'util/url_mocks'

RSpec.configure do |c|
  c.filter_run :focus => true
  c.run_all_when_everything_filtered = true
end