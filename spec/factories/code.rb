# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :code, :class => 'Code' do
    game               { Game.first || FactoryGirl.create(:game) }
    sequence(:number)  { |n| n }
    name              ''
    ko                'null'
    bonus             1.0
    task
  end
end