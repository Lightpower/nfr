require "spec_helper"

describe Team do
  before :all do
    destroy_simple_game
    create_simple_game
  end

  after :all do
    destroy_simple_game
  end

  context 'codes_number_in_zone' do
    before :each do
      # pass some codes
      @user = User.first
      @zone = Zone.first
      CodeFacade.input({game: @zone.game, code_string: @zone.access_code.code_strings.first.data, user: @user})
      @codes = @zone.tasks.select{ |i| i.is_available?(@user.team) }.first.codes
      code_strings = @codes.map {|code| code.code_strings.first.data}
      CodeFacade.input({game: @zone.game, code_string: code_strings.join(' '), user: @user})
    end

    it 'success' do
      codes_number = @codes.inject(0) { |res, item| res + item.bonus }
      @user.team.codes_number_in_zone(@zone).should == codes_number

      time = []
      time << Time.now
      # take a hint
      code_res = CodeFacade.get_hint({task_id: @zone.tasks.first.id, user: @user})
      codes_number_hint = @zone.tasks.first.hints.by_order.first.cost
      @user.team.codes_number_in_zone(@zone).should == codes_number + codes_number_hint

      time << Time.now
      # more codes
      next_task = @zone.tasks[1]
      # enter accept code if need
      code_res = CodeFacade.input({game: @zone.game, code_string: next_task.access_code.show_code, user: @user}) if next_task.access_code.present?
      codes_2 = next_task.codes
      code_strings = codes_2.map {|code| code.code_strings.first.data}
      code_res = CodeFacade.input({game: @zone.game, code_string: code_strings.join(' '), user: @user})
      codes_number_2 = codes_2.inject(0) { |res, item| res + item.bonus }
      @user.team.codes_number_in_zone(@zone).should == codes_number +
          codes_number_hint +
          (next_task.access_code.try(:bonus) || 0) +
          codes_number_2

      # check getting the codes number by time
      @user.team.codes_number_in_zone(@zone, time[0]).should == codes_number
      @user.team.codes_number_in_zone(@zone, time[1]).should == codes_number + codes_number_hint
      @user.team.codes_number_in_zone(@zone, Time.now).should == codes_number + codes_number_hint  + next_task.access_code.bonus + codes_number_2

    end
  end

  context 'codes_in_zone' do
    before :each do
      # pass some codes
      @user = User.first
      @zone = Zone.first
      CodeFacade.input({game: @zone.game, code_string: @zone.access_code.code_strings.first.data, user: @user})
      @codes = @zone.tasks.first.codes
      code_strings = @codes.map {|code| code.code_strings.first.data}
      CodeFacade.input({game: @zone.game, code_string: code_strings.join(' '), user: @user})
    end

    it 'success' do
      @user.team.codes_in_zone(@zone).map(&:code).should =~ [@zone.access_code] + @codes

      # more codes
      next_task = @zone.tasks[1]
      # enter accept code if need
      CodeFacade.input({game: @zone.game, code_string: next_task.access_code.show_code, user: @user}) if next_task.access_code.present?
      codes_2 = next_task.codes
      code_strings = codes_2.map {|code| code.code_strings.first.data}
      CodeFacade.input({game: @zone.game, code_string: code_strings.join(' '), user: @user})
      @user.team.codes_in_zone(@zone).map(&:code).should =~ [@zone.access_code] + @codes + [next_task.access_code] + codes_2
    end
  end

  context 'last_code_in_zone' do
    before :each do
      # pass some codes
      @user = User.first
      @zone = Zone.first
      CodeFacade.input({game: @zone.game, code_string: @zone.access_code.code_strings.first.data, user: @user})
      @codes = @zone.tasks.first.codes
      code_strings = @codes.map {|code| code.code_strings.first.data}
      CodeFacade.input({game: @zone.game, code_string: code_strings.join(' '), user: @user})
    end

    it 'success' do
      @user.team.last_code_in_zone(@zone).should == { time: @user.team.team_codes.last.created_at, state: Code::STATES[@user.team.team_codes.last.state] }

      # take a hint
      CodeFacade.get_hint({task_id: @zone.tasks.first.id, user: @user})
      @user.reload
      @user.team.last_code_in_zone(@zone).should == { time: @user.team.team_hints.last.created_at, state: :hint }
    end
  end
end