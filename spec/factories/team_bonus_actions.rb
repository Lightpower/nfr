# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_bonus_action do
    game             { Game.first || FactoryGirl.create(:game) }
    team_bonus
    is_ok false
  end
end
