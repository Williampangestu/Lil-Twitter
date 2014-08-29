get '/create_acct' do
  erb :create_acct
end

post '/create_acct' do
  user = User.create(name: params[:username], password: params[:password])
  session[:username] = user.name
  redirect to('/dashboard')
end

get '/login' do
  erb :login_page
end

post '/login' do
  session[:error] = nil if !session[:error]
  user = User.find_by(name: params[:username])
  if user == nil
    session[:error] = 'Invalid username.'
    redirect '/login'
  elsif user.password != params[:password]
    session[:error] = 'Invalid password.'
    redirect '/login'
  else
    session[:username] = params[:username]
    session[:error] = nil
    redirect to ('/dashboard')
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/follow/:username' do
  User.find_by(name:session[:username]).followees << User.find_by(name: params[:username])
  redirect "/user/#{params[:username]}"
end

post '/unfollow/:username' do
  User.find_by(name:session[:username]).followees.delete(User.find_by(name: params[:username]))
  redirect "/user/#{params[:username]}"
end

post '/user/:username/tweets/new' do
    tweet = Tweet.create(content: params[:content])
    user = User.find_by_name(params[:username])
    user.tweets << tweet
    redirect "/user/#{params[:username]}"
end
