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
  project_links = project_config['url']
  project_links  = [project_links] unless project_links.is_a? Array

  errors = project_links.inject([]) do |errors_list, link|
    status = Connection.new(link).status_code
    errors_list << {server: link, error: status} if status != '200'
    errors_list
  end

  result = errors.empty? ? "ok" : "down"
  resposta = {project_name: project_key, status: result, errors: errors}
  resposta.to_json
end
