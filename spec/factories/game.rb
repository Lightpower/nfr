# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game, :class => 'Game' do
    sequence(:number)  { |n| n }
    sequence(:name)    { |n| "Game #{n}" }
    game_type          'conquest'
    format_id          { FactoryGirl.create(:format).id }
    start_date         Time.now
  end
end

