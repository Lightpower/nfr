# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :zone_holder do
    game             { Game.first || FactoryGirl.create(:game) }
    zone
    team
    team_code
    time       Time.new
    amount     0
  end
end
