# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_config, :class => 'GameConfig' do
    game
    time         1800
    bonus        60
    total_bonus  600
  end
end

