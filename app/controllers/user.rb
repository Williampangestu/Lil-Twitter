get '/create_acct' do
  erb :create_acct
end

post '/create_acct' do
  User.create(name: params[:username], password: params[:password])
  redirect to('/')
end

get '/login' do
  erb :login_page
end

post '/login' do
  if User.exist?(params[:username], params[:password])
    session[:username] = params[:username]
    redirect to ('/dashboard')
  else
    redirect to('/')
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/follow/:username' do
  User.find_by(name:session[:username]).followees << User.find_by(name: params[:username])
  redirect "/#{params[:username]}"
end

post '/unfollow/:username' do
  User.find_by(name:session[:username]).followees.delete(User.find_by(name: params[:username]))
  redirect "/#{params[:username]}"
end

post '/:username/tweets/new' do
    tweet = Tweet.create(content: params[:content])
    user = User.find_by_name(params[:username])
    user.tweets << tweet
    redirect "/#{params[:username]}"
end