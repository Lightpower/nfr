# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_request do
    game             { Game.first || FactoryGirl.create(:game) }
    team
  end
end



