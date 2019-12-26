require 'rails_helper'

describe User do
  describe '#create' do
    #1. 画像以外があれば登録できる
  it "画像以外があれば登録できる" do
    user = build(:user)
    expect(user).to be_valid
  end 

    #2. ニックネームがなければ登録できない
  it "ニックネームがなければ登録できない" do
    user = build(:user, nickname: nil)
    user.valid?
    expect(user.errors[:nickname]).to include("can't be blank")
  end

  # 3. emailが空では登録できないこと
  it "emailが空では登録できない" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  # 4. passwordが空では登録できないこと
  it "passwordが空では登録できないこと" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  # 5. passwordが存在してもpassword_confirmationが空では登録できないこと
  it "passwordが存在してもpassword_confirmationがからでは登録できないこと" do
    user = build(:user, password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  #6. passwordが7文字以上であれば登録できること
  it "passwordが7文字以上であれば登録できること" do
    user = build(:user, password:"0000000", password_confirmation:"0000000")
    user.valid?
    expect(user).to be_valid
  end

  #7. passwordが6文字以下であれば登録できないこと
  it "passwordが6文字以下であれば登録できないこと" do
    user = build(:user, password:"000000", password_confirmation:"000000")
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
  end

  #8. 名字がなければ登録できない
  it "名字がなければ登録できない" do
    user = build(:user, name_family: nil)
    user.valid?
    expect(user.errors[:name_family]).to include("can't be blank")
  end

end


end
 