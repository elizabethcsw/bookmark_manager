ENV['RACK_ENV'] ||= 'development'


require 'sinatra/base'
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'data_mapper_setup'



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

    link = Link.new(url: @url, title: @title)

    params[:tags].split(" ").each do
      |x| link.tags << Tag.first_or_create(name: x)
    end

    # tag = Tag.first_or_create(name: @tag_name)
    # link.tags << tag
    # p link.tags.map(&:name)
    # p link.tags.name
    p link.save
    # p link
    redirect '/links'
  end

  post '/links/tag' do
    session[:name] = params[:name]
    tag = Tag.first(name: session[:name])
    # p "this is tag.links"
    # p tag.links
    # @links is empty before ternary
    tag ? (@links = tag.links) : (@links = [])
    # @links = tag.links after ternary if tag is true
    # @links = [] after ternary if tag is nil
    # tag.links will return an error if tag is nil
    p "this is tag"
    p tag

    erb :'links/bubbles'
  end

  get '/links/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    # p "this is @links"
    # p @links
    # p "this is tag.links"
    # p tag.links
     erb :'links/bubbles'
  end

  run! if app_file == $0
end
