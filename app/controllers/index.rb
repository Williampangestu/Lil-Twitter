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
end