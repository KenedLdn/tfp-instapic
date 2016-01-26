require 'rails_helper'

RSpec.describe InstapostsController, type: :controller do
  describe "Action: instaposts#index" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
end
