# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team, :class => 'Team' do
    sequence(:name) { |n| "Team #{n}" }
    users           { [FactoryGirl.create(:user)] }
  end
end