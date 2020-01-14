require 'rails_helper'

RSpec.describe "API V1 Sessions", :vcr, type: 'request' do
  describe "POST /api/v1/sessions" do
    context "with valid parameters" do
      before(:each) do
        @user = User.create(email: "joe@example.com", password: "password", password_confirmation: "password")
      end

      let(:valid_params) do
        {
          "email": "joe@example.com",
          "password": "password",
        }
      end

      it "logs in an existing user" do
        post "/api/v1/sessions", params: valid_params
        expect(response).to have_http_status(200)
        api_key = JSON.parse(response.body)["data"]["attributes"]["api_key"]
        expect(api_key).to eq(@user.api_key)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          "email": "joe@example.com",
          "password": "different_password",
        }
      end

      it "cannot log in an existing user with invalid credentials" do
        post "/api/v1/sessions", params: invalid_params
        expect(response).to have_http_status(400)
        error = JSON.parse(response.body)["error"]
        expect(error).to eq('Bad credentials.')
      end
    end
  end
end
