require 'spec/spec_helper'
require 'healthchecker'
require 'rack/test'
require 'mocha'

describe 'Healthchecker App' do
  include Rack::Test::Methods

  before(:all) do
    
    
    @config_mock = {"projects" =>
                      {"my-200-project" =>
                        {"id" => "200-project",
                        "name" =>"my-200-project",
                        "url" => "http://www.return.200.com/healthcheck"},
                      "my-404-project"=>
                        {"id" =>"404-project",
                        "name" => "my-404-project",
                        "url" => "http://www.return.404.com/healthcheck"},
                      "my-500-project"=>
                        {"id" =>"500-project",
                        "name" => "my-500-project",
                        "url" => "http://www.return.500.com/healthcheck"}
                        }
                    }
  end

  def app
    Sinatra::Application
  end

  it "index page" do
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/'
    last_response.should be_ok
  end
  

  it "config on json format" do
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/config'
    last_response.should be_ok
    last_response.body.should == "{\"projects\":{\"my-500-project\":{\"name\":\"my-500-project\",\"url\":\"http://www.return.500.com/healthcheck\",\"id\":\"500-project\"},\"my-404-project\":{\"name\":\"my-404-project\",\"url\":\"http://www.return.404.com/healthcheck\",\"id\":\"404-project\"},\"my-200-project\":{\"name\":\"my-200-project\",\"url\":\"http://www.return.200.com/healthcheck\",\"id\":\"200-project\"}}}"
  end
  
  it "should return a project status 200" do
    expected_response = "{\"project_name\":\"my-200-project\",\"status\":\"200\"}"
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/project/my-200-project'
    last_response.should be_ok
    last_response.body.should == expected_response
  end
  
  it "should return a project status 404" do
    expected_response = "{\"project_name\":\"my-404-project\",\"status\":\"404\"}"
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/project/my-404-project'
    last_response.should be_ok
    last_response.body.should == expected_response
  end
  
  it "should return a project status 500" do
    expected_response = "{\"project_name\":\"my-500-project\",\"status\":\"500\"}"
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/project/my-500-project'
    last_response.should be_ok
    last_response.body.should == expected_response
  end
end
