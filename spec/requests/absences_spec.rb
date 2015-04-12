require "rails_helper"

RSpec.describe "Absences", type: :request do
  subject { JSON.parse(response.body) }

  describe "GET /absences" do
    context "when user is not logged in" do
      it "returns 403" do
        get absences_path

        expect(response).to have_http_status(403)
      end
    end

    context "when user is logged in" do
      before { sign_in(user) }
      before { Timecop.freeze(2015, 4, 11, 22, 25, 26) }
      after { Timecop.return }

      let(:user) { create_user }
      let!(:absence) { create_absence(user_id: user.id) }

      it "returns absences" do
        get absences_path

        expect(response).to have_http_status(200)
        expect(subject["absences"][0]["at"]).to eq("2015-04-13T22:25:26.000Z")
        expect(subject["absences"][0]["shift"]).to eq("morning")
      end
    end
  end

  describe "POST /absences" do
    context "when user is not logged in" do
      it "returns 403" do
        post absences_path

        expect(response).to have_http_status(403)
      end
    end

    context "when user is logged in" do
      before { Timecop.freeze(2015, 4, 11, 22, 32, 33) }
      after { Timecop.return }

      before { sign_in }

      it "creates an absence" do
        post absences_path, at: Time.current.xmlschema, shift: "night"

        expect(response).to have_http_status(201)
        expect(subject["absence"]["at"]).to eq("2015-04-11T22:32:33.000Z")
        expect(subject["absence"]["shift"]).to eq("night")
      end
    end
  end
end
