get '/' do
  erb :main_page
end

get '/login' do
  erb :login_page
end

post '/create_acct' do
  User.create(name: params[:username], password: params[:password])
  redirect to('/')
end

get '/create_acct' do
  erb :create_acct
end

post '/login' do
  if User.exist?(params[:username], params[:password])
    session[:username] = params[:username]
    redirect to ('/dashboard')
  else
    redirect to('/')
  end
end

get '/dashboard' do
  @user = User.find_by(username: session[:username])
  @tweets = user.tweets
  @tweets << user.followees.tweets
  @tweets.order(created_at: :desc)
  erb :dashboard
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
  redirect "/#{params[:username]}"

