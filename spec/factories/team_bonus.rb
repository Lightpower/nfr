# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_bonu, :class => 'TeamBonus' do
    team nil
    bonus_type "MyString"
    rate 1.5
    amount 1
  end
end
