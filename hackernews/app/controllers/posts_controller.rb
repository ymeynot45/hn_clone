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

  end

  def update

  end

  def edit
    @post = Post.find_by_id(params[:id])
    redirect_to @post
  end

end
