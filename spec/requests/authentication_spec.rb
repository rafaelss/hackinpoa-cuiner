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
      let(:user) do
        User.create!(
          first_name: "foo",
          last_name: "baz",
          email: "foo@bar.com",
          password: "aaa123",
          password_confirmation: "aaa123"
        )
      end

      it "authenticates the user" do
        post authenticate_user_path, email: user.email, password: "aaa123"

        expect(response).to have_http_status(302)
        expect(response.headers["Location"]).to eq("http://www.example.com/user")
      end
    end
  end
end
