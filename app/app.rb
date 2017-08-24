require 'sinatra/base'
require_relative 'models/link'
require_relative 'data_mapper_setup'

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
    p @tag_name = params[:tags]
    p link = Link.new(url: @url, title: @title)
    p tag = Tag.first_or_create(name: @tag_name)
    p link.tags << tag
    p link.tags.map(&:name)
    p link.tags.name
    p link.save
    p link
    redirect '/links'
  end

  run! if app_file == $0
end
