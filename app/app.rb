require 'sinatra/base'
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'data_mapper_setup'

ENV['RACK_ENV'] ||= 'development'

class BookmarkManager < Sinatra::Base

  enable :sessions

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

  post '/links/tag' do
    session[:name] = params[:name]
    tag = Tag.first(name: session[:name])
    p @links.class
    p tag
    @links = tag ? tag.links : []
    @links

    erb :'links/bubbles'
  end

  get '/links/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
     erb :'links/bubbles'
  end

  run! if app_file == $0
end
