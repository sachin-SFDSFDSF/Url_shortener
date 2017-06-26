require 'rails_helper'

RSpec.describe Url, type: :model do

  it "is valid with a valid url" do
    url = build(:url)
    expect(url).to be_valid
  end

  it "is invalid without a url" do
    url = build(:url, original_url: nil)
    url.valid?
    expect(url.errors[:original_url]).to include("Please enter the URL you want to shorten")
  end
end