# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :format do
    sequence(:name)      { |n| "Format #{n}" }
    sequence(:css_class) { |n| "format_#{n}" }
    project_id           { FactoryGirl.create(:project).id }
  end
end

