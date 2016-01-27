class InstapostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def show
    @instapost = Instapost.find_by_id(params[:id])
    render text: 'Not Found', status: :not_found if @instapost.blank?
  end

  def new
    @instapost = Instapost.new
  end

  def create
    @instapost = current_user.instaposts.create(instapost_params)
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
