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

  describe "Action: instaposts#edit" do
    it "should successfully show the edit page if the instapost is found" do
      user = FactoryGirl.create(:user)
      instapost = FactoryGirl.create(:instapost)
      sign_in user

      get :edit, id: instapost.id
      expect(response).to have_http_status(:success)
    end

    it "should properly handle error if the instapost is not found" do
      user = FactoryGirl.create(:user)
      instapost = FactoryGirl.create(:instapost)
      sign_in user

      get :edit, id: 'ABC'
      expect(response).to have_http_status(:not_found)
    end

    it "should require users to be logged in" do
      instapost = FactoryGirl.create(:instapost)
      get :edit, id: instapost.id
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Action: instaposts#update" do
    it "should successfully update the database if the instapost is found" do
      user = FactoryGirl.create(:user)
      sign_in user

      p = FactoryGirl.create(:instapost, message: 'Initial message')
      patch :update, id: p.id, instapost: {message: 'Changed'}
      expect(response).to redirect_to root_path
      p.reload
      expect(p.message).to eq('Changed')
    end

    it "should properly handle error if the instapost is not found" do
      user = FactoryGirl.create(:user)
      sign_in user

      patch :update, id: 'ABC', instapost: {message: 'Changed'}
      expect(response).to have_http_status(:not_found)
    end

    it "should properly handle error if updated without a message" do
      user = FactoryGirl.create(:user)
      sign_in user

      p = FactoryGirl.create(:instapost, message: 'Initial message')
      patch :update, id: p.id, instapost: {message: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      p.reload
      expect(p.message).to eq('Initial message')
    end

    it "should require users to be logged in" do
      instapost = FactoryGirl.create(:instapost)
      patch :update, id: instapost.id, instapost: {message: 'Changed'}
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Action: instaposts#destroy" do
    it "should allow user to destroy a post" do
      user = FactoryGirl.create(:user)
      sign_in user
      instapost = FactoryGirl.create(:instapost)
      delete :destroy, id: instapost.id
      expect(response).to redirect_to root_path
      expect(Instapost.find_by_id(instapost.id)).to eq(nil)
    end

    it "should return a 404 message if we cannot find a instapost with the id that is specified" do
      user = FactoryGirl.create(:user)
      sign_in user
      delete :destroy, id: 'ABC'
      expect(response).to have_http_status(:not_found)
    end

    it "should require users to be logged in" do
      instapost = FactoryGirl.create(:instapost)
      delete :destroy, id: instapost.id
      expect(response).to redirect_to new_user_session_path
      expect(Instapost.find_by_id(instapost.id).blank?).to eq(false)
    end

  end

end
