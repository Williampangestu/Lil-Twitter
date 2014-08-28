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

get '/dashboard' do
	@user = User.find_by(username: session[:username])
	@tweets = user.tweets
	@tweets << user.followees.tweets
	@tweets.order(created_at: :desc)
	erb :dashboard
end

get '/user/:username' do

end
