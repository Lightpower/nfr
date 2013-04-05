# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_bonus_action do
    team_bonus nil
    is_ok false
    timestamps "MyString"
  end
end
