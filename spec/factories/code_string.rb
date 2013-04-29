# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :code_string, :class => 'CodeString' do
    game             { Game.first || FactoryGirl.create(:game) }
    sequence(:data)  { |n| "DR#{n}" }
    code
  end
end