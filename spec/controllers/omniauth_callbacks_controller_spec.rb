require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do

  describe "GET '/auth/facebook'" do

    before(:each) do
      valid_facebook_login_setup
      get  user_facebook_omniauth_authorize_path
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    it "should set user_id" do
      expect(session[:user_id]).to eq(User.last.id)
    end

    it "should redirect to root" do
      expect(response).to redirect_to root_path
    end
  end

  describe "GET '/auth/failure'" do

    it "should redirect to root" do
      get "users/auth/failure"
      expect(response).to redirect_to root_path
    end
  end

end