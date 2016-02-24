require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
enable :sessions
# set :sessions, true



# set the db name (will be created if the # db does not already exist)
set :database, "sqlite3:sinatraExercise.sqlite3"

#Require model AFTER setting database
require './Models/users'
# require './models/posts'
get '/' do
  erb :home
end


get '/welcome' do
  current_user
  erb :welcome
end


post '/sign-in' do
 @user = User.where(email: params[:email]).first
 if @user && @user.password == params[:password]
    flash[:notice] = "terrific sign in"
    session[:user_id] = @user.id
    redirect '/welcome'
  else

    flash[:notice] = "invalid sign in"
    redirect '/'
  end
end


def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end




