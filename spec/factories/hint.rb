# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hint, :class => 'Hint' do
    sequence(:number)  { |q| q }
    data               '<b>Valuable hint</b>'
    cost               1.0
    task_id            { FactoryGirl.create(:task) }
  end
end