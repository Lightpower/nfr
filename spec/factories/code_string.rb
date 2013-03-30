# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :code_string, :class => 'CodeString' do
    sequence(:data)  { |n| "DR#{n}" }
    code
  end
end