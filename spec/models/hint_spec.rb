require "spec_helper"

describe Hint do

  context 'by_order' do
    before :each do
      zone = FactoryGirl.create(:zone)
      @task = FactoryGirl.create(:task, zone: zone)
      [4, 2, 7, 9, 10, 1, 5, 3, 6, 8].map { |n| FactoryGirl.create(:hint, task: @task, number: n)}
    end

    it 'success' do
      @task.hints.by_order.map(&:number).should ==  @task.hints.map(&:number).sort
    end
  end

  context 'is_got_by_team?' do
    before :each do
      @team = FactoryGirl.create(:team)
      zone = FactoryGirl.create(:zone)
      task = FactoryGirl.create(:task, zone: zone)
      @hints = [FactoryGirl.create(:hint, task: task, number: 1), FactoryGirl.create(:hint, task: task, number: 2)]

      GameStrategy::Context.get_hint({game: zone.game, task_id: task.id, user: @team.users.first})
    end

    it 'success' do
      @hints.first.is_got_by_team?(@team).should be_true
      @hints.last.is_got_by_team?(@team).should be_false
    end
  end
end