require 'rails_helper'

RSpec.describe "Users", type: :request do
  subject { JSON.parse(response.body) }

  describe "POST /users" do
    before { sign_in }

    it "creates an user" do
      post users_path, first_name: "foo", last_name: "baz", email: "foo@bar.com", password: "aaa123", password_confirmation: "aaa123"

      expect(response).to have_http_status(201)
      expect(response.headers["Location"]).to match(/\/users\/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/)
      expect(subject["user"]["id"]).to match(/^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/)
      expect(subject["user"]["first_name"]).to eq("foo")
      expect(subject["user"]["last_name"]).to eq("baz")
      expect(subject["user"]["email"]).to eq("foo@bar.com")
    end
  end
end
