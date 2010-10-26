require 'spec/spec_helper'
require 'healthchecker'
require 'rack/test'
require 'mocha'

describe 'Healthchecker App' do
  include Rack::Test::Methods

  before(:all) do
      @config_mock = {"projects"=>{"my-200-project" => "http://www.return.200.com/healthcheck", 
                                   "my-404-project" => "http://www.return.404.com/healthcheck",
                                   "my-500-project" => "http://www.return.500.com/healthcheck"}} 
  end

  def app
    Sinatra::Application
  end

  it "index page" do
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/'
    last_response.should be_ok
    last_response.body.should include "my-200-project"
    last_response.body.should include "my-404-project"
    last_response.body.should include "my-500-project"
  end
  

  it "config on json format" do
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/config'
    last_response.should be_ok
    last_response.body.should ==  "{\"projects\":{\"my-200-project\":\"http://www.return.200.com/healthcheck\",\"my-404-project\":\"http://www.return.404.com/healthcheck\",\"my-500-project\":\"http://www.return.500.com/healthcheck\"}}"
  end
  
  it "should return a project status 200" do
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/projeto/my-200-project'
    last_response.should be_ok
    last_response.body.should == "200" 
  end
  
  it "should return a project status 404" do
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/projeto/my-404-project'
    last_response.should be_ok
    last_response.body.should == "404" 
  end
  
  it "should return a project status 500" do
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/projeto/my-500-project'
    last_response.should be_ok
    last_response.body.should == "500" 
  end
end