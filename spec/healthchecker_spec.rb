require 'spec_helper'
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
                        "url" => ["http://www.return.200.com/healthcheck",
                                  "http://www.return2.200.com/healthcheck",
                                  "http://www.return3.200.com/healthcheck"]},
                      "my-404-project"=>
                        {"id" =>"404-project",
                        "name" => "my-404-project",
                        "url" => "http://www.return.404.com/healthcheck"},
                      "my-500-project"=>
                        {"id" =>"500-project",
                        "name" => "my-500-project",
                        "url" => "http://www.return.500.com/healthcheck"},
                      "doesnt-exist-project"=>
                        {"id" =>"doesnt-exist-project",
                        "name" => "doesnt-exist-project",
                        "url" => "http://www.dontexist123456.com/healthcheck"}
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
    pending
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/config'
    last_response.should be_ok
    last_response.body.should == "{\"projects\":{\"my-200-project\":{\"id\":\"200-project\",\"name\":\"my-200-project\",\"url\":[\"http://www.return.200.com/healthcheck\",\"http://www.return2.200.com/healthcheck\",\"http://www.return3.200.com/healthcheck\"]},\"my-404-project\":{\"id\":\"404-project\",\"name\":\"my-404-project\",\"url\":\"http://www.return.404.com/healthcheck\"},\"my-500-project\":{\"id\":\"500-project\",\"name\":\"my-500-project\",\"url\":\"http://www.return.500.com/healthcheck\"}},\"doesnt-exist-project\":{\"id\":\"doesnt-exist-project\",\"name\":\"doesnt-exist-project\",\"url\":\"http://www.dontexist123456.com/healthcheck\"}}"
  end

  it "should return a project status 200" do
    expected_response = "{\"project_name\":\"my-200-project\",\"status\":\"ok\",\"errors\":[]}"
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/project/my-200-project'
    last_response.should be_ok
    last_response.body.should == expected_response
  end

  it "should return a project status 404" do
    expected_response = "{\"project_name\":\"my-404-project\",\"status\":\"down\",\"errors\":[{\"server\":\"http://www.return.404.com/healthcheck\",\"error\":\"404\"}]}"
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/project/my-404-project'
    last_response.should be_ok
    last_response.body.should == expected_response
  end

  it "should return a project status 500" do
    expected_response = "{\"project_name\":\"my-500-project\",\"status\":\"down\",\"errors\":[{\"server\":\"http://www.return.500.com/healthcheck\",\"error\":\"500\"}]}"
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/project/my-500-project'
    last_response.should be_ok
    last_response.body.should == expected_response
  end

  it "should return a project status 404 when doesn't exist" do
    expected_response = "{\"project_name\":\"doesnt-exist-project\",\"status\":\"down\",\"errors\":[{\"server\":\"http://www.dontexist123456.com/healthcheck\",\"error\":\"404\"}]}"
    YAML.expects(:load_file).once.with('config.yml').returns(@config_mock)
    get '/project/doesnt-exist-project'
    last_response.should be_ok
    last_response.body.should == expected_response
  end
end
