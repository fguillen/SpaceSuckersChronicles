require "active_record"
require "sqlite3"
require "logger"

ActiveRecord::Base.logger =
  Logger.new( "#{ENV["ROOT"]}/log/active_record.#{ENV["ENVIRONMENT"]}.log" )

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "#{ENV["ROOT"]}/db/#{ENV["ENVIRONMENT"]}.db"
)