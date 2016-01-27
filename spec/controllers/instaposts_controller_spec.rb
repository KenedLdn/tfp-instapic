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
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "Action: instaposts#create" do
    it "should successfully create a message in database" do
      post :create, instapost: {message: 'Hello!'}
      expect(response).to redirect_to root_path
      
      instapost = Instapost.last
      expect(instapost.message).to eq('Hello!')
    end
  end
  
end
