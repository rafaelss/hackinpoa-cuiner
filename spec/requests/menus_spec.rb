require 'rails_helper'

RSpec.describe "Menus", type: :request do
  subject { JSON.parse(response.body) }

  describe "GET /menus" do
    context "when user is not logged in" do
      it "returns 403" do
        get menus_path

        expect(response).to have_http_status(403)
      end
    end

    context "when user is logged in" do
      before { sign_in }

      it "returns menus" do
        get menus_path

        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST /menus" do
    context "when user is not logged in" do
      it "returns 403" do
        post menus_path

        expect(response).to have_http_status(403)
      end
    end

    context "when user is logged in" do
      before { sign_in }

      it "creates a menu" do
        post menus_path, name: "pizza", price: 10.99, price_per_person: 2.99, number_of_people: 2

        expect(response).to have_http_status(201)
        expect(response.headers["Location"]).to match(/\/menus\/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/)
        expect(subject["menu"]["name"]).to eq("pizza")
      end
    end
  end
end
