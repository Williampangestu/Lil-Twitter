get '/' do
  erb :main_page, layout: false
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
















