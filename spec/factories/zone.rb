# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :zone, :class => 'Zone' do
    game             { Game.first || FactoryGirl.create(:game) }
    number           { Zone.all.size + 1 }
    sequence(:name)  { |n| "Zone #{n}" }
    access_code      { FactoryGirl.create(:code, task_id: nil) }
  end
end