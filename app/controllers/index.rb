get '/' do
  erb :main_page
end

get '/login' do
  erb :login_page
end

get '/create_acct' do
  erb :create_acct
end

post '/login' do
	session[:username] = params[:username]
	redirect '/dashboard'
end

get 'dashboard' do

end

get '/:username' do
  @user = User.find_by_name(params[:username])
  @tweets = @user.tweets
  erb :profile_page
end

post '/:username/tweets/new' do
  tweet = Tweet.create(content: params[:content])
  user = User.find_by_name(params[:username])
  user.tweets << tweet
  redirect "/Will"
end


# get '/:username' do
#   @user = User.find_by_name(params[:username])
#   @tweets = @user.tweets
#   erb :profile_page
# end

# post '/:username/tweets/new' do
#   user = User.find_by_name(params[:username])
#   user.tweets << Tweet.create(content: params[:content])
#   redirect "/Will"
# end

