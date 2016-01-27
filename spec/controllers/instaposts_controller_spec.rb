require 'rails_helper'

RSpec.describe InstapostsController, type: :controller do
  describe "Action: instaposts#index" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "Action: instaposts#new" do
    it "should successfully show the new form" do
      user = FactoryGirl.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end

    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Action: instaposts#create" do
    it "should successfully create a message in database" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, instapost: {message: 'Hello!'}
      expect(response).to redirect_to root_path

      instapost = Instapost.last
      expect(instapost.message).to eq('Hello!')
      expect(instapost.user).to eq(user)
    end

    it "should properly handle request if submitted without a message" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, instapost: {message: ''}
      expect(response).to have_http_status(:unprocessable_entity)

      expect(Instapost.count).to eq 0
    end

    it "should require users to be logged in" do
      post :create, instapost: {message: 'Hello!'}
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Action: instaposts#show" do
    it "should successfully show the detail page if the instapost is found" do
      instapost = FactoryGirl.create(:instapost)
      get :show, id: instapost.id
      expect(response).to have_http_status(:success)
    end

    it "should properly handle error if the instapost is not found" do
      instapost = FactoryGirl.create(:instapost)
      get :show, id: 'ABC'
      expect(response).to have_http_status(:not_found)
    end
  end

end
