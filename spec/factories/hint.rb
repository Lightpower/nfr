# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hint, :class => 'Hint' do
    game               { Game.first || FactoryGirl.create(:game) }
    sequence(:number)  { |q| q }
    data               '<b>Valuable hint</b>'
    cost               1.0
    task
  end
end