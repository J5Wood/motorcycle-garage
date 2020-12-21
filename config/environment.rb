ENV['SINATRA_ENV'] ||= "development"
ENV['SESSION_SECRET'] ||= "da9a406890703a6f82133ba9e85fa1ff4aaf61b928ef469053bbf399d2fd5cd9c63bf37a852eba1c404ca9f28af5b0e7164f71149996cae54c6cd0c6b8f828b0"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'