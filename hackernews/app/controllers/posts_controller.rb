class PostsController < ApplicationController 

  def create

  end

  def new

  end

  def index
    @posts = Post.order(:created_at).reverse_order
  end

  def show

  end

  def destroy

  end

  def put

  end

end
