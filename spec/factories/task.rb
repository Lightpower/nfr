# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task, :class => 'Task' do
    game              { Game.first || FactoryGirl.create(:game) }
    sequence(:number) {|n| n}
    sequence(:name)   {|n| "Task #{n}"}
    data              '<i>Text of task</i>'
    zone
  end
end