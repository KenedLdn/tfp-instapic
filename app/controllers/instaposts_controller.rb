class InstapostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def show
    @instapost = Instapost.find_by_id(params[:id])
    return render_not_found if @instapost.blank?
  end

  def new
    @instapost = Instapost.new
  end

  def update
    @instapost = Instapost.find_by_id(params[:id])
    return render_not_found if @instapost.blank?
    @instapost.update_attributes(instapost_params)
    if @instapost.valid?
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @instapost = Instapost.find_by_id(params[:id])
    return render_not_found if @instapost.blank?
    @instapost.destroy
    redirect_to root_path
  end

  def edit
    @instapost = Instapost.find_by_id(params[:id])
    return render_not_found if @instapost.blank?
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

  def render_not_found
    render text: 'Not Found', status: :not_found
  end
end
