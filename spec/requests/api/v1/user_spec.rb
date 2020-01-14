require 'rails_helper'

RSpec.describe "API V1 Users", :vcr, type: 'request' do
  describe "POST /api/v1/users" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          "email": "joe@example.com",
          "password": "password",
          "password_confirmation": "password"
        }
      end

      it "creates a new user" do
        expect { post "/api/v1/users", params: valid_params }.to change(User, :count).by(+1)
        expect(response).to have_http_status :created
        api_key = JSON.parse(response.body)["data"]["attributes"]["api_key"]
        expect(api_key).to_not be_empty
        expect(api_key.length).to eq(24)
      end

      it "creates a user with the correct attributes" do
         post "/api/v1/users", params: valid_params
         expect(User.last.email).to eq("joe@example.com")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          "email": "joe@example.com",
          "password": "password",
          "password_confirmation": "different_password"
        }
      end

      it "cannot create a new user with invalid attributes" do
        expect { post "/api/v1/users", params: invalid_params }.to_not change(User, :count)
        expect(response).to have_http_status(400)
        error = JSON.parse(response.body)["error"]
        expect(error).to_not be_empty
      end
    end
  end
end
