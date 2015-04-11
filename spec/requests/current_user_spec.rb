require 'rails_helper'

RSpec.describe "Current User", type: :request do
  subject { JSON.parse(response.body) }

  describe "GET /user" do
    context "when user is not logged in" do
      it "returns 403" do
        get current_user_path

        expect(response).to have_http_status(403)
      end
    end

    context "when user is logged in" do
      let(:user) do
        User.create!(
          first_name: "foo",
          last_name: "baz",
          email: "foo@bar.com",
          password: "aaa123",
          password_confirmation: "aaa123"
        )
      end

      before do
        post authenticate_user_path, email: user.email, password: "aaa123"
      end

      it "returns an user" do
        get current_user_path

        expect(response).to have_http_status(200)
        expect(subject["user"]["id"]).to match(/^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/)
        expect(subject["user"]["first_name"]).to eq("foo")
        expect(subject["user"]["last_name"]).to eq("baz")
        expect(subject["user"]["email"]).to eq("foo@bar.com")
      end
    end
  end
end
