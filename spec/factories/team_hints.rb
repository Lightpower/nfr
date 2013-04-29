# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_hint do
    game             { Game.first || FactoryGirl.create(:game) }
    team
    hint
  end
end
