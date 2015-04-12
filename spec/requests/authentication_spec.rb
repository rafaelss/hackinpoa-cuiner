require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  describe "POST /user/authenticate" do
    context "with wrong credentials" do
      it "returns 403" do
        post authenticate_user_path, email: "a@b.com", password: "abc"

        expect(response).to have_http_status(403)
      end
    end

    context "with valid credentials" do
      let(:user) { create_user }

      it "authenticates the user" do
        post authenticate_user_path, email: user.email, password: "aaa123"

        expect(response).to have_http_status(302)
        expect(response.headers["Location"]).to eq("http://www.example.com/user")
      end
    end
  end

  describe "POST /user/logout" do
    context "when user is not logged in" do
      it "returns 403" do
        post logout_user_path

        expect(response).to have_http_status(403)
      end
    end

    context "when user is logged in" do
      before { sign_in }

      it "logs the user out" do
        post logout_user_path

        expect(response).to have_http_status(200)
      end
    end
  end
end
