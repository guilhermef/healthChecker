#healthchecker.rb
require 'sinatra'
require 'lib/connection'
require 'yaml'
require 'haml'
require 'json'

  

# get '/' do
#   @projects = []
#   config['projects'].each do |project|
#     response = Connection.new(project['link'])
#     @projects << {:name => project['name'], :status => response.status_code}
#   end
#   haml :index
# end

get "/config" do
  config = YAML::load_file('config.yml')
  config.to_json
end


get "/:project_name" do
  config = YAML::load_file('config.yml')
  project_link = config['projects'][params[:project_name]]
  response = Connection.new(project_link)
  response.status_code
end