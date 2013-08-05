class PostsController < ApplicationController 

  def create
    @post = Post.new(params[:post]) #:title => params[:post][:title], :content => params[:post][:content]) 
    @post.save

    redirect_to @post
  end

  def new

  end

  def index
    @posts = Post.order(:created_at).reverse_order
  end

  def show
    @post = Post.find(params[:id])
   
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to action: 'index'
  end

  def update
    Post.update_attributes(params[:post])
    #set up if/else for error handling later
  end

  def edit
    @post = Post.find_by_id(params[:id])
  end

end
