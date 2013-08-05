get '/' do
  @posts = Post.order(:created_at).reverse_order
  erb :index
end

get '/login' do

  erb :login
end

get '/logout' do
  session[:user_id] = nil
  redirect to "/login"
end

get '/profile/:user_id' do
  @user_page = User.find_by_id(params[:user_id])
  @current_user = User.find_by_id(session[:user_id])
  @posts = @user_page.posts
  @comments = @user_page.comments
  if @user_page.id == session[:user_id]
    #side nav bar true
  end
  erb :profile
end

get '/post/:post_id' do
  @post = Post.find_by_id(params[:post_id])

  erb :post
end


post '/comment/:post_id' do
  Comment.create(:body => params[:body], :user_id => session[:user_id], :post_id => params[:post_id])
  redirect "/post/#{params[:post_id]}"
end

post '/login' do
  @current_user = User.authenticate(params[:user][:username], params[:user][:password])
  if @current_user
    session[:user_id] = @current_user.id
    redirect "/profile/#{@current_user.id}"
  else
    @errors_login = true
    erb :login
  end
end

post '/new_post' do
  Post.create(title: params[:title], content: params[:content], user_id: session[:user_id])

  redirect "/"
end

post '/register' do
  user = User.new(params[:user])
  if user.valid?
    user.save
    session[:user_id] = user.id
  redirect "/profile/#{user.id}"
  else
    @errors_create = user.errors.messages
    erb :login
  end
end

post '/vote/:post_id' do
  if request.xhr?
    if "Thumbs Up"
      #something
    elsif "Thumbs Down"
      #something
    end
  elsif params[:vote] == "Thumbs Up"
    PostVote.create(user_id: session[:user_id], post_id: params[:post_id], upvote: 1)
  elsif params[:vote] == "Thumbs Down"
    PostVote.create(user_id: session[:user_id], post_id: params[:post_id], downvote: 1)
  end
  redirect to "/post/#{params[:post_id]}"
end
