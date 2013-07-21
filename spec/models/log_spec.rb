# encoding: UTF-8
require "spec_helper"

describe Log do

  context 'check logs adding' do
    before :all do
      destroy_simple_game
      create_simple_game

      @team_boltons = Team.first
      @user_boltons = @team_boltons.users.first
      @team_trants = Team.last
      @user_trants = @team_trants.users.first

      @zone_access_codes = Zone.all.map(&:access_code)
      @task_access_codes = Task.all.map(&:access_code)

      @free_tasks_codes = Task.where(code_id: nil).map(&:codes).flatten
      @access_task_codes = Task.where('code_id is not null').map(&:codes).flatten
    end

    after :all do
      destroy_simple_game
    end

    it 'logs' do
      Log.all.should be_blank

      # Try to pass code from not available zone
      Team.all.each { |team| GameStrategy::Context.send_code({game: @free_tasks_codes.first.game, code_string: @free_tasks_codes.first.show_code, user: team.users.first}) }

      log_number = 0
      compare_logs(Log.all[log_number],
                   {
                       code: @free_tasks_codes.first,
                       result: :not_available,
                       team: @team_boltons
                   })
      log_number += 1
      compare_logs(Log.all[log_number],
                   {
                       code: @free_tasks_codes.first,
                       result: :not_available,
                       team: @team_trants
                   })

      # Pass code to zone
      Team.all.each { |team| GameStrategy::Context.send_code({game: @zone_access_codes.first.game, code_string: @zone_access_codes.first.show_code, user: team.users.first}) }

      log_number += 1
      compare_logs(Log.all[log_number],
                   {
                       code: @zone_access_codes.first,
                       result: :accessed,
                       team: @team_boltons
                   })

      log_number += 1
      compare_logs(Log.all[log_number],
                   {
                       code: @zone_access_codes.first,
                       result: :accessed,
                       team: @team_trants
                   })

      # Repeat first code
      Team.all.each do |team|
        GameStrategy::Context.send_code({game: @free_tasks_codes.first.game, code_string: @free_tasks_codes.first.show_code, user: team.users.first})
      end

      log_number += 1
      compare_logs(Log.all[log_number],
                   {
                       code: @free_tasks_codes.first,
                       result: :accepted,
                       team: @team_boltons
                   })
      log_number += 1
      compare_logs(Log.all[log_number],
                   {
                       code: @free_tasks_codes.first,
                       result: :accepted,
                       team: @team_trants
                   })

      # Get different hints for each team
      hints = [Task.first.hints.by_order.first, Task.last.hints.by_order.first]
      res = GameStrategy::Context.get_hint({game: hints.first.game, task: hints.first.task, user: @user_boltons})
      res[:result].should == :hint_accessed
      # the next one hint costs more than Trants have
      res = GameStrategy::Context.get_hint({game: hints.first.game, task: hints.last.task, user: @user_trants})
      res[:result].should == :hint_not_enough_costs

      log_number += 1
      compare_logs(Log.all[log_number],
                   {
                       hint: hints.first,
                       result: :hint_accessed,
                       team: @team_boltons
                   })
      log_number += 1
      compare_logs(Log.all[log_number],
                   {
                       hint: hints.last,
                       result: :hint_not_enough_costs,
                       team: @team_trants
                   })
    end
  end
end

private

def compare_logs(log, params)
  log.should be_present
  user = params[:team].users.first
  log.login.should == user.email
  log.data.should == params[:code].show_code if params[:code].present?
  log.data.should == "Hint #{params[:hint].id} (цена #{params[:hint].cost})" if params[:hint]
  Code::STATES[log.result_code].should == params[:result]
  log.team_id.should == params[:team].id
end