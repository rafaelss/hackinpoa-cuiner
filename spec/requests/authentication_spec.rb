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

        expect(response).to have_http_status(200)
      end
    end
  end
end
