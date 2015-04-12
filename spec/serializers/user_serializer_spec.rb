require "rails_helper"

describe UserSerializer, type: :serializer do
  let(:model) { create_user }
  subject(:serializer) { described_class.new(model) }

  it ".id" do
    expect(subject.id).to eq(model.public_id)
  end

  it ".name" do
    expect(subject.name).to eq("foo")
  end

  it ".email" do
    expect(subject.email).to eq("foo@bar.com")
  end

  it ".phone" do
    expect(subject.phone).to eq("5198765432")
  end

  it ".photo_url" do
    expect(subject.photo_url).to eq("http://cloud.host/default/image.jpg")
  end

  describe ".as_json" do
    subject { serializer.as_json["user"] }

    it "should have declared attributes" do
      expect(subject.keys).to eq([:id, :name, :email, :phone, :photo_url])
    end
  end
end
