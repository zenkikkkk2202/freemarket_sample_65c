require 'rails_helper'

describe Address do
  describe '#create' do
    #1,電話番号が登録できる
  it "電話番号が登録できる" do
    address = build(:address)
    expect(address).to be_valid
  end

    #2,郵便番号がなければ登録できない
  it "郵便番号がなければ登録できない" do
    address = build(:address, post_code: nil)
    address.valid?
    expect(address.errors[:post_code]).to include("can't be blank")
  end

    #3,都道府県が選択されなければ登録できない
  it "都道府県が選択されなければ登録できない" do 
    address = build(:address, prefecture_id: nil)
    address.valid?
    expect(address.errors[:prefecture_id]).to include("can't be blank")
  end

    #4,市町村区を入力しなければ登録できない
  it "市町村区を入力しなければ登録できない" do
    address = build(:address, city: nil)
    address.valid?
    expect(address.errors[:city]).to include("can't be blank")
  end
    #5,番地を入力しなければ登録できない
  it "番地を入力しなければ登録できない" do 
    address = build(:address, address: nil)
    address.valid?
    expect(address.errors[:address]).to include("can't be blank")
  end

    #6,市町村区が50文字以上であれば登録できない
  it "市町村区が50文字以上であれば登録できない" do
    address = build(:address, city: "awawawawawawawawawawawwawawawawawawawaawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawaw")
    address.valid?
    expect(address.errors[:city]).to include("is too long (maximum is 50 characters)")
  end

    #7,番地が50文字以上であれば登録できない
  it "番地が50文字以上であれば登録できない" do
    address = build(:address, address:"awawawawawawawawawawawwawawawawawawawaawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawawaw")
    address.valid?
    expect(address.errors[:address]).to include("is too long (maximum is 50 characters)")
  end

end
end