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
  it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
    user = build(:user, password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  #6. passwordが7文字以上であれば登録できること
  it "passwordが7文字以上であれば登録できること" do
    user = build(:user)
    user.valid?
    expect(user).to be_valid
  end

  #7. passwordが6文字以下であれば登録できないこと
  it "passwordが6文字以下であれば登録できないこと" do
    user = build(:user, password:"123e56", password_confirmation:"123e56")
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
  end

  #8. 名字がなければ登録できない
  it "名字がなければ登録できない" do
    user = build(:user, name_family: nil)
    user.valid?
    expect(user.errors[:name_family]).to include("can't be blank")
  end

  #9. 名前がなければ登録できない
  it "名前がなければ登録できない" do
    user = build(:user, name_last: nil)
    user.valid?
    expect(user.errors[:name_last]).to include("can't be blank")
  end

  #10. カナ名字がなければ登録できない
  it "カナ名字がなければ登録できない" do
    user = build(:user, name_kana_f: nil)
    user.valid?
    expect(user.errors[:name_kana_f]).to include("can't be blank")
  end

  #11. カナ名前がなければ登録できない
  it "カナ名前がなければ登録できない" do
    user = build(:user, name_kana_l: nil)
    user.valid?
    expect(user.errors[:name_kana_l]).to include("can't be blank")
  end

  #12. 西暦を選択しなければ登録できない
  it "西暦を選択しなければ登録できない" do
    user = build(:user, birthday_y: nil)
    user.valid?
    expect(user.errors[:birthday_y]).to include("can't be blank")
  end

  #13. 月を選択しなければ登録できない
  it "月を選択しなければ登録できない" do 
    user = build(:user, birthday_m: nil)
    user.valid?
    expect(user.errors[:birthday_m]).to include("can't be blank")
  end

  #14. 日にちを選択しなければ登録できない
  it "日にちを選択しなければ登録できない" do
    user = build(:user, birthday_d: nil) 
    user.valid?
    expect(user.errors[:birthday_d]).to include("can't be blank")
  end

  #15. パスワードの暗号キーがなければ登録できない
  it "パスワードの暗号キーがなければ登録できない" do
    user = build(:user, encrypted_password: nil)
    user.valid?
    expect(user.errors[:encrypted_password]).to include("can't be blank")
  end


end


end
 