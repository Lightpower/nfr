require 'spec_helper'

describe TeamCode do

  context 'codes_number_of_team' do
    before :each do
      create_simple_game

      @team = Team.first
      @user = @team.users.first
      @zone = Zone.first
      @task_access_code = @zone.tasks.where('code_id is not null').first.access_code
      @codes = @zone.tasks.select{|item| item.access_code.blank?}.map(&:codes).flatten
    end

    it 'success' do
      # Try to pass code from not available zone
      CodeFacade.input({game: @zone.game, code_string: @codes.first.show_code, user: @user})
      TeamCode.codes_number_of_team(@team, @codes.first.zone).should == 0

      # Pass code to zone - codes_number_in_zone is still 0
      CodeFacade.input({game: @zone.game, code_string: @zone.access_code.show_code, user: @user})
      TeamCode.codes_number_of_team(@team, @zone.access_code.zone).should == 0

      # Repeat the first code
      codes_number = @codes.first.bonus
      CodeFacade.input({game: @zone.game, code_string: @codes.first.show_code, user: @user})
      TeamCode.codes_number_of_team(@team, @codes.first.zone).should == codes_number

      # Get different hints for each team
      hint = @zone.tasks.first.hints.by_order.first
      res = CodeFacade.get_hint({task: hint.task, user: @user})
      res[:result].should == :hint_accessed
      codes_number += hint.cost
      TeamCode.codes_number_of_team(@team, @codes.first.zone).should == codes_number
    end

    # codes_number_of_team with time is being tested in team_spec

  end

end
