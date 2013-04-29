require "spec_helper"

describe Task do

  context 'by_order' do
    before :each do
      @zone = FactoryGirl.create(:zone)
      [4, 2, 7, 9, 10, 1, 5, 3, 6, 8].map { |n| FactoryGirl.create(:task, zone: @zone, number: n)}
    end

    it 'success' do
      @zone.tasks.by_order.map(&:number).should ==  @zone.tasks.map(&:number).sort
    end
  end

  context 'is_available?' do
    before :each do
      create_simple_game
      @zone = Zone.first
      @user = User.first
      # Access to zone
      CodeFacade.input({game: @zone.game, code_string: @zone.access_code.show_code, user: @user})
    end

    it 'success' do
      # task from zone without access
      task = Zone.where('id <> ?', @zone.id).first.tasks.where(code_id: nil).first
      task.is_available?(@user.team).should be_false

      # Access to zone
      CodeFacade.input({game: task.game, code_string: task.zone.access_code.show_code, user: @user})
      task.is_available?(@user.team).should be_true

      # Task is secured by access code
      task = Task.where(zone_id: @zone.id).where('code_id is not null').first
      task.is_available?(@user.team).should be_false

      # Enter the codes from this zone to get costs for getting task
      task_2 = Task.where(zone_id: @zone.id).where(code_id: nil).first
      task_2.codes.each {|code| CodeFacade.input({game: task_2.game, code_string: code.show_code, user: @user}) }

      # Enter access code of task
      CodeFacade.input({game: task.game, code_string: task.access_code.show_code, user: @user})
      task.is_available?(@user.team).should be_true
    end
  end

  context 'hints_of (team)' do
    before :each do
      create_simple_game
      zone = Zone.first
      @user = User.first
      # Access to zone
      CodeFacade.input({game: zone.game, code_string: zone.access_code.show_code, user: @user})
      # get some codes to get costs for hints
      @task = Task.where(zone_id: zone.id).where(code_id: nil).first
      @task.codes.each {|code| CodeFacade.input({game: @task.game, code_string: code.show_code, user: @user}) }
    end

    it 'success' do
      @task.hints_of(@user.team).should be_blank
      # Get the first hint
      CodeFacade.get_hint({task: @task, user: @user})
      @task.hints_of(@user.team).should == [@task.hints.by_order.first]
    end
  end


end