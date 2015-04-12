require "rails_helper"

describe UserSerializer, type: :serializer do
  let(:model) { create_user }
  subject(:serializer) { described_class.new(model) }

  it ".id" do
    expect(subject.id).to eq(model.public_id)
  end

  it ".first_name" do
    expect(subject.first_name).to eq("foo")
  end

  it ".last_name" do
    expect(subject.last_name).to eq("baz")
  end

  it ".email" do
    expect(subject.email).to eq("foo@bar.com")
  end

  describe ".as_json" do
    subject { serializer.as_json["user"] }

    it "should have declared attributes" do
      expect(subject.keys).to eq([:id, :first_name, :last_name, :email])
    end
  end
end
