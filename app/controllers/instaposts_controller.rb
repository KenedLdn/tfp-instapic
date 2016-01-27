class InstapostsController < ApplicationController
  def index
  end

  def new
    @instapost = Instapost.new
  end

  def create
    @instapost = Instapost.create(instapost_params)
    if @instapost.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def instapost_params
    params.require(:instapost).permit(:message)
  end
end
