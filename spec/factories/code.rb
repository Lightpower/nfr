# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :code, :class => 'Code' do
    sequence(:number)  { |n| n }
    name              ''
    ko                'null'
    bonus             1.0
    task_id           { FactoryGirl.create(:task) }
  end
end