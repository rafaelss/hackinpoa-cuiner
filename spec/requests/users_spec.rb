require 'rails_helper'

RSpec.describe "Users", type: :request do
  subject { JSON.parse(response.body) }

  describe "POST /users" do
    it "creates an user" do
      post users_path, name: "foo", email: "foo@bar.com", password: "aaa123", password_confirmation: "aaa123"

      expect(response).to have_http_status(201)
      expect(response.headers["Location"]).to match(/\/users\/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/)
      expect(subject["user"]["id"]).to match(/^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/)
      expect(subject["user"]["name"]).to eq("foo")
      expect(subject["user"]["email"]).to eq("foo@bar.com")
      expect(session["user_id"]).to eq(subject["user"]["id"])
    end
  end
end
