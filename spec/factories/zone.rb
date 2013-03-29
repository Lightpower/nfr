# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :zone, :class => 'Zone' do
    number           { Zone.all.size + 1 }
    sequence(:name)  { |n| "Zone #{n}" }
    code_id          { FactoryGirl.create(:code, task_id: nil).id }
  end
end