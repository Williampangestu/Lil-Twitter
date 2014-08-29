get '/' do
  erb :main_page, layout: false
end

get '/dashboard' do
  if signed_in?
    @user = User.find_by(name: session[:username])
    @tweets = []
    @user.tweets.each do |tweet|
      @tweets << tweet
    end
    @user.followees.each do |followee|
      followee.tweets.each do |tweet|
        @tweets << tweet
      end
    end
    @tweets.sort! {|a,b| a.created_at <=> b.created_at}
    erb :dashboard
  else
    redirect '/'
  end
end

post '/search' do
  results = ""
  User.all.each do |user|
    if user.name.include?(params[:search])
      results << user.name + " "
    end
  end
  redirect to("/search_view/?answers=#{results}")
end

get '/search_view/?' do
  p params
  @results = params[:answers].split(" ")
  erb :search_view
end

get '/user/:username' do
  if signed_in?
    # p User.find_by_name(params[:username])
    # p session[:username]
    @user = User.find_by_name(params[:username]) || User.find_by(name: session[:username])
    @tweets = []
    @user.tweets.each do |tweet|
      @tweets << tweet
    end
    erb :profile_page
  else
    redirect '/'
  end
end

get '/user/:username/followings' do
  @user = User.find_by_name(params[:username])
  @followings = @user.followees
  erb :following
end

get '/user/:username/followers' do
  @user = User.find_by_name(params[:username])
  @followers = @user.followers
  erb :follower
end
















