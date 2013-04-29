# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game, :class => 'Game' do
    sequence(:number)  { |n| n }
    sequence(:name)    { |n| "Game #{n}" }
    format             "NFR"
    start_date         Time.now
  end
end

