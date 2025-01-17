require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it 'is valid with a valid long_url' do
      url = Url.new(long_url: 'https://example.com')
      expect(url).to be_valid
    end

    it 'is invalid without a long_url' do
      url = Url.new(long_url: nil)
      expect(url).not_to be_valid
      expect(url.errors[:long_url]).to include("can't be blank")
    end

    it 'is invalid with an improperly formatted long_url' do
      url = Url.new(long_url: 'invalid_url')
      expect(url).not_to be_valid
      expect(url.errors[:long_url]).to include('is invalid')
    end
  end

  describe 'short_url generation' do
    it 'generates a unique short_url before creation' do
      url = Url.create(long_url: 'https://example.com')
      expect(url.short_url).not_to be_nil
      expect(url.short_url.length).to eq(6)
    end
  end
end
