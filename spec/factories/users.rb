FactoryBot.define do

  factory :user do
    id                    {"1"}
    nickname              {"abe"}
    sequence(:email) { |n| "hiro#{n}@example.com"}
    password              {"abc2efg"}
    password_confirmation {"abc2efg"}
    name_family           {"田中"}
    name_last             {"明"}
    name_kana_f           {"タナカ"}
    name_kana_l           {"アキラ"}
    birthday_y            {"1998"}
    birthday_m            {"4"}
    birthday_d            {"23"}
    encrypted_password    {"abc2efg"}
    created_at            {"20111111"}
    updated_at            {"20111111"}

  end

end