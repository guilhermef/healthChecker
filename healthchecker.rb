require "rubygems"
require "bundler/setup"

require 'sinatra'
require 'lib/connection'
require 'yaml'
require 'haml'
require 'json'

  
before do
  @config = YAML::load_file('config.yml')
end

get '/' do
  @projects = @config['projects'].keys
  haml :index
end

get "/config" do
  @config.to_json
end


get "/projeto/:project_name" do
  project_link = @config['projects'][params[:project_name]]
  response = Connection.new(project_link)
  response.status_code
end
