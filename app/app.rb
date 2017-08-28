ENV['RACK_ENV'] ||= 'development'


require 'sinatra/base'
require 'sinatra/flash'
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'models/user'
require_relative 'data_mapper_setup'



class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  register Sinatra::Flash

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

  get '/signup' do
    @user = User.new
     erb :'links/signup'
  end

  post '/users' do
    p @email = params[:email]
    p @password = params[:password]
    p @password2=params[:password2]
    p @user = User.new(email: @email, password: @password, password_confirmation: @password2)
    # @user.id will return nil until we execute @user.save
    if @user.save
      #save returns true/false depending on whether the model is successfully saved to the database.
      p session[:user_id] = @user.id
      redirect '/links'
    else
      p "cannot execute @user.save"
      flash.now[:notice] = "Password and confirmation password do not match"
      erb :'links/signup'
    end
  end

#introducing memoization
#storing the result of User.get using conditional assignment to an instance variable
# It’s important to notice that the result of get is assigned to an instance variable instead of a local variable. If you were to use a local variable (a variable without the @ symbol) then user wouldn’t be stored and the get query would occur on every call to current_user. Nothing would have improved.
  helpers do
    def current_user
     @current_user ||= User.get(session[:user_id])
    end
  end

  run! if app_file == $0
end
