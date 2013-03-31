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
      CodeFacade.input({code_string: @zone.access_code.code_strings.first.data, user: @user})
      @codes = @zone.tasks.first.codes
      code_strings = @codes.map {|code| code.code_strings.first.data}
      CodeFacade.input({code_string: code_strings.join(' '), user: @user})
    end

    it 'success' do
      codes_number = @codes.inject(0) { |res, item| res + item.bonus }
      @user.team.codes_number_in_zone(@zone).should == codes_number

      time = []
      time << Time.now
      # take a hint
      CodeFacade.get_hint({task_id: @zone.tasks.first.id, user: @user})
      codes_number_hint = @zone.tasks.first.hints.by_order.first.cost
      @user.team.codes_number_in_zone(@zone).should == codes_number + codes_number_hint

      time << Time.now
      # more codes
      codes_2 = @zone.tasks[1].codes
      code_strings = codes_2.map {|code| code.code_strings.first.data}
      CodeFacade.input({code_string: code_strings.join(' '), user: @user})
      codes_number_2 = codes_2.inject(0) { |res, item| res + item.bonus }
      @user.team.codes_number_in_zone(@zone).should == codes_number + codes_number_hint + codes_number_2

      # check getting the codes number by time
      @user.team.codes_number_in_zone(@zone, time[0]).should == codes_number
      @user.team.codes_number_in_zone(@zone, time[1]).should == codes_number + codes_number_hint
      @user.team.codes_number_in_zone(@zone, Time.now).should == codes_number + codes_number_hint + codes_number_2

    end
  end

  context 'codes_in_zone' do
    before :each do
      # pass some codes
      @user = User.first
      @zone = Zone.first
      CodeFacade.input({code_string: @zone.access_code.code_strings.first.data, user: @user})
      @codes = @zone.tasks.first.codes
      code_strings = @codes.map {|code| code.code_strings.first.data}
      CodeFacade.input({code_string: code_strings.join(' '), user: @user})
    end

    it 'success' do
      @user.team.codes_in_zone(@zone).map(&:code).should =~ [@zone.access_code] + @codes

      # more codes
      codes_2 = @zone.tasks[1].codes
      code_strings = codes_2.map {|code| code.code_strings.first.data}
      CodeFacade.input({code_string: code_strings.join(' '), user: @user})
      @user.team.codes_in_zone(@zone).map(&:code).should =~ [@zone.access_code] + @codes + codes_2
    end
  end

  context 'last_code_in_zone' do
    before :each do
      # pass some codes
      @user = User.first
      @zone = Zone.first
      CodeFacade.input({code_string: @zone.access_code.code_strings.first.data, user: @user})
      @codes = @zone.tasks.first.codes
      code_strings = @codes.map {|code| code.code_strings.first.data}
      CodeFacade.input({code_string: code_strings.join(' '), user: @user})
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