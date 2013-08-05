class PostsController < ApplicationController 

  def create
    @post = Post.new(params[:post])
    if @post.valid?
      @post.save
      redirect_to @post
    else
      @errors = @post.errors.messages
      render 'new'
    end

    
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
    @post = Post.update_attributes(params[:post])
    if @post.valid?
      @post.update
      redirect_to @post
    else
      @errors = @post.errors.messages
      render 'edit'
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
  end

end
