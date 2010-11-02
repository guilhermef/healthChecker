#!/usr/bin/env ruby
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
  haml :index
end

get "/config" do
  @config.to_json
end


get "/project/:project_name" do
  project_key = params[:project_name]
  project_config = @config['projects'][project_key]
  project_link = project_config['url']
  response = Connection.new(project_link)
  resposta = {:project_name => project_key, :status => response.status_code}
  resposta.to_json
end
