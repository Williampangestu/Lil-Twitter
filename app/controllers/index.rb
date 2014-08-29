get '/' do
  erb :main_page, layout: false
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
  if signed_in?
    @user = User.find_by(name: session[:username])
    @tweets = @user.tweets
    @user.followees.each do |followee|
      @tweets << followee.tweets
    end
    @tweets.order(created_at: :desc)
    erb :dashboard
  else
    redirect '/'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/:username' do
  if signed_in?
    # p User.find_by_name(params[:username])
    # p session[:username]
    @user = User.find_by_name(params[:username]) || User.find_by(name: session[:username])
    @tweets = @user.tweets
    erb :profile_page
  else
    redirect '/'
  end
end

post '/:username/tweets/new' do
    tweet = Tweet.create(content: params[:content])
    user = User.find_by_name(params[:username])
    user.tweets << tweet
    redirect "/#{params[:username]}"
end

get '/:username/followings' do
  @user = User.find_by_name(params[:username])
  @followings = @user.followees
  erb :following
end

get '/:username/followers' do
  @user = User.find_by_name(params[:username])
  @followers = @user.followers
  erb :follower
end
















