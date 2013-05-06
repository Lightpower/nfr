# coding: utf-8
class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users
  def index
    @users = User.accessible_by(current_ability)
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
  end

  # GET /users/1/edit
  def edit
    render 'users/edit', locals: {team_request_list: prepare_team_requests}
  end

  # POST /users
  def create
    # Only Admin and team captain can set user's team role
    if @user.save
      redirect_to @user, notice: 'Пользователь успешно создан!'
    else
      render action: "new"
    end
  end

  # PUT /users/1
  def update
    # Only Admin and team captain can change user's team role
    if cannot? :manage, :role
      params[:user].delete(:role)
    end
    if @user.password.blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    # Team request
    if params[:user].keys.include? 'team_id'
      if @user.is_captain?
        # Captain cannot change his team
        params[:user].delete(:team_id)
      elsif params[:user][:team_id].present?
        # if user want to change its team, create TeamRequest and clear his team_id
        TeamRequest.create(team_id: params[:user][:team_id], user_id: params[:id], by_user: true)
        params[:user][:team_id] = ''
      end
    end
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'Данные пользователя успешно изменены.'
    else
      render action: "edit"
    end
  end

  def team_requests
    render 'users/team_requests', locals: {team_request_list: prepare_team_requests}
  end

  # DELETE /users/1
  def destroy
    @user.destroy

    redirect_to users_path
  end


  ######################################
  private ##############################
  ######################################

  def prepare_team_requests
    result = {
        from_me: @user.team_requests.select {|tr|  tr.by_user } || [],
        to_me:   @user.team_requests.select {|tr| !tr.by_user } || []
    }
    if @user.is_captain?
      team = @user.team
      result.merge!({
        from_users: team.team_requests.select {|tr|  tr.by_user } || [],
        to_users:   team.team_requests.select {|tr| !tr.by_user } || []
      })
    end
    result
  end

end