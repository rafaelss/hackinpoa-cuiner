require 'rails_helper'

RSpec.describe "Search", type: :request do
  subject { JSON.parse(response.body) }

  describe "GET /search" do
    let(:menu) { create_menu }

    it "returns results" do
      expect(Menu).to receive(:search).with("churras").and_return([menu])

      get search_path, q: "churras"

      expect(response).to have_http_status(200)
      expect(subject["menus"][0]["id"]).to eq(menu.public_id)
      expect(subject["menus"][0]["name"]).to eq(menu.name)
    end

    context "with price parameter" do
      it "returns results" do
        expect(Menu).to receive(:search).with("churras", numericFilters: ["price<=10"]).and_return([menu])

        get search_path, q: "churras", price: 10

        expect(response).to have_http_status(200)
        expect(subject["menus"][0]["id"]).to eq(menu.public_id)
        expect(subject["menus"][0]["name"]).to eq(menu.name)
      end
    end

    context "with persons parameter" do
      it "returns results" do
        expect(Menu).to receive(:search).with("churras", numericFilters: ["max_number_of_people>=50"]).and_return([menu])

        get search_path, q: "churras", persons: 50

        expect(response).to have_http_status(200)
        expect(subject["menus"][0]["id"]).to eq(menu.public_id)
        expect(subject["menus"][0]["name"]).to eq(menu.name)
      end
    end
  end
end
