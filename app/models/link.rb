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
DataMapper.setup(:default, 'postgres://localhost/bookmark_manager_test')

DataMapper.finalize
DataMapper.auto_upgrade!
