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

      let(:valid_attributes) do
        {
          name: "pizza", price: 10.99, price_per_person: 2.99, number_of_people: [2, 10], tags: ["calabresa", "portuguesa"]
        }
      end

      it "creates a menu" do
        post menus_path, valid_attributes

        expect(response).to have_http_status(201)
        expect(response.headers["Location"]).to match(/\/menus\/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/)
        expect(subject["menu"]["name"]).to eq("pizza")
        expect(subject["menu"]["price"]).to eq(10.99)
        expect(subject["menu"]["price_per_person"]).to eq(2.99)
        expect(subject["menu"]["number_of_people"]).to eq([2, 10])
        expect(subject["menu"]["tags"]).to eq(["calabresa", "portuguesa"])
      end
    end
  end
end
