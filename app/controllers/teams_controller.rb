# encoding: UTF-8
class TeamsController < ApplicationController
  load_and_authorize_resource

  # GET /teams
  def index
    @teams = Team.accessible_by(current_ability)
  end

  # GET /teams/1
  def show
  end

  # GET /teams/new
  def new
  end

  # GET /teams/1/edit
  def edit
    render 'teams/edit', locals: {team_request_list: prepare_team_requests}
  end

  # POST /teams
  def create
    # Current user will be the captain of new team
    @team.captain = current_user
    if @team.save!
      current_user.team = @team
      current_user.save!
      redirect_to @team, notice: 'Команда успешно создана!'
    else
      render action: "new"
    end
  end

  # PUT /teams/1
  def update
    if @team.update_attributes(params[:team])
      redirect_to @team, notice: 'Данные команды успешно изменены.'
    else
      render action: "edit"
    end
  end

  # DELETE /teams/1
  def destroy
    @team.destroy

    redirect_to teams_path
  end

          ######################################
  private ##############################
          ######################################

  def prepare_team_requests
    result = {
        from_me: [],
        to_me:   []
    }
    result.merge!({
      from_users: @team.team_requests.select {|tr|  tr.by_user } || [],
      to_users:   @team.team_requests.select {|tr| !tr.by_user } || []
    })
    result
  end
end
