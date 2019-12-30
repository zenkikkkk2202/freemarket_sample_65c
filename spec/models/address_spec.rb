require 'rails_helper'

describe Address do
  describe '#create' do
    #1,電話番号以外があれば登録できる
  it "電話番号以外があれば登録できる" do
    address = build(:address)
    expect(address).to be_valid
  end
end
end