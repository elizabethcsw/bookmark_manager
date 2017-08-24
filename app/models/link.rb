require 'data_mapper'
require 'dm-postgres-adapter'

class Link
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :url, String
end
# If you want the logs displayed you have to do this before the call to setup
# DataMapper::Logger.new($stdout, :debug)

# A Postgres connection:
# DataMapper.setup(:default, "postgres://fmellyifecklkf:59302d29f4a30aff181e0530f07d8dc6973dbc6e9dfbb68b12e4a463dc747ed6@ec2-54-225-118-55.compute-1.amazonaws.com:5432/dekuf6vept6ta6/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")

DataMapper.finalize
DataMapper.auto_upgrade!
