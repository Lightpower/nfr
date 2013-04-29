# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_bonus, :class => 'TeamBonus' do
    game       { Game.first || FactoryGirl.create(:game) }
    team 
    bonus_type "Multiplier"
    name       "Test bonus"
    rate 1.5
    amount 1
  end
end
