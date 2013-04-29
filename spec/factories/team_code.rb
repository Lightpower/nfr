# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_code, :class => 'TeamCode' do
    game             { Game.first || FactoryGirl.create(:game) }
    team
    code
    zone
  end
end
