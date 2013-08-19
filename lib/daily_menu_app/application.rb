require 'sinatra'
require 'rack-cache'
require 'json'
require 'logger'

module DailyMenuApp
  class Application < Sinatra::Application
    if ENV['MEMCACHIER_SERVERS']
      servers = ENV['MEMCACHIER_SERVERS'].split(',')

      dalli_client = Dalli::Client.new(servers, {
        username: ENV['MEMCACHIER_USERNAME'],
        password: ENV['MEMCACHIER_PASSWORD']
      })

      use Rack::Cache, {
        metastore:   dalli_client,
        entitystore: dalli_client
      }
    end

    logger = Logger.new(STDOUT)
    fetcher = Fetcher.new(logger)

    get '/menus/*' do
      cache_control :public, max_age: 1800

      begin
        location = params[:splat].first

        content_type :json
        fetcher.fetch(location).to_json
      rescue NotFound
        status 404
      end
    end
  end
end
