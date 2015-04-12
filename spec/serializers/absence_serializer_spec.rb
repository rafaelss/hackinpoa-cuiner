require "rails_helper"

describe AbsenceSerializer, type: :serializer do
  let(:model) { create_absence }
  subject(:serializer) { described_class.new(model) }

  it ".at" do
    expect(subject.at).to eq(model.at)
  end

  it ".shift" do
    expect(subject.shift).to eq("morning")
  end

  describe ".as_json" do
    subject { serializer.as_json["absence"] }

    it "should have declared attributes" do
      expect(subject.keys).to eq([:at, :shift])
    end
  end
end
