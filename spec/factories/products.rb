FactoryBot.define do
  factory :product do
    name          {"fujiwara"}
    description   {"ただです"}
    category      {"1"}
    condition     {"1"}
    charge        {"1"}
    prefecture_id {"1"}
    city          {"matubara"}
    day           {"4"}
    price         {"5000"}
    fee           {"5"}
    profit        {"5"}
    user          {"harry"}
    user_id       {"4"}
  end
end