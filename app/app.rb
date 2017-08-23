require 'sinatra/base'
require_relative 'models/link'

class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links/new' do
    erb :'links/save'
  end

  post '/links' do
    p @title = params[:title]
    p @url = params[:url]
    Link.create(url: @url, title: @title)
    redirect '/links'
  end

  run! if app_file == $0
end
