#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require "bundler/setup"

require 'sinatra'
require 'lib/connection'
require 'yaml'
require 'haml'
require 'json'
require 'compass'

class Healthchecker < Sinatra::Base

  configure do
    set :public_folder, File.dirname(__FILE__) + '/static'
    set :haml, {:format => :html5, :escape_html => true}
    set :sass, {:style => :compact, :debug_info => false}
    Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.rb'))
  end

  get '/stylesheets/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    sass :"stylesheets/#{params[:name]}", Compass.sass_engine_options
  end

  before do
    @config = YAML::load_file('config.yml')
  end

  get '/' do
    haml :index
  end

  get "/project/:project_name.json" do
    content_type :json

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
end