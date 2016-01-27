class InstapostsController < ApplicationController
  def index
  end
  
  def new
    @instapost = Instapost.new
  end
  
  def create
    @instapost = Instapost.create(instapost_params)
    redirect_to root_path
  end
  
  private
  
  def instapost_params
    params.require(:instapost).permit(:message)
  end
end
