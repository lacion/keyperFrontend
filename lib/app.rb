$: << File.dirname(File.expand_path(__FILE__))
require "bundler"
Bundler.setup
require "sinatra/base"
require 'rest_client'
require 'json'

module App

  class Base < Sinatra::Base

    set :root, File.expand_path('../../', __FILE__)

    configure do
      enable :logging
      set :server, :puma
    end

    configure :development do
      require "sinatra/reloader"
      require "better_errors"
      register Sinatra::Reloader
      use BetterErrors::Middleware
      BetterErrors.application_root = File.expand_path("..", __FILE__)
    end

    def get_data(path)
      response = RestClient::Request.new(
          :method => :get,
          :url => 'http://localhost:8080/' + path.to_s,
          :user => 'luis',
          :password => 'secret',
          :headers => {:accept => :json,
                       :content_type => :json}
      ).execute
      JSON.parse(response.to_str)
    end

    get '/' do
      @personList = get_data('person/list')
      erb :base
    end


  end

end