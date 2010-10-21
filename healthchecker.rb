#healthchecker.rb
require 'sinatra'
require 'connection'
require 'yaml'
require 'haml'


get '/' do
  config = YAML::load(File.read('config.yml'))
  @projects = []
  config['projects'].each do |project|
    status = Connection.is_200?(project['link'])
    @projects << {:name => project['name'], :status => status}
  end
  haml :index
end
