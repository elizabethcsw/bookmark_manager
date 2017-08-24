require 'sinatra/base'
require_relative 'models/link'

ENV['RACK_ENV'] ||= 'development'

class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    #@links is an array of instance variables from the class Link
    p @links
    erb :'links/index'
  end

  get '/links/new' do
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
