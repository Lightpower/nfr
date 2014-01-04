# encoding: UTF-8
class UserMailer < ActionMailer::Base
  default from: 'support@nfr.kiev.ua'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Добро пожаловать на сайт NeFoRmat!') if user.email
  end

  def team_request_from_team(team, user)
    @team = team
    @user = user
    mail(to: user.email, subject: 'Приглашение в команду') if user.email
  end

  def team_request_from_user(team, user)
    @team = team
    @user = user
    mail(to: user.email, subject: 'Запрос на участие в команде') if team.captain.email
  end

  def accept_team_request_from_team(team, user)
    @team = team
    @user = user
    mail(to: user.email, subject: 'Приглашение в команду принято!') if user.email
  end

  def accept_team_request_from_user(team, user)
    @team = team
    @user = user
    mail(to: user.email, subject: 'Вас приняли в команду!') if team.captain.email
  end

  def reject_team_request_from_team(team, user)
    @team = team
    @user = user
    mail(to: user.email, subject: 'Приглашение в команду отклонено') if user.email
  end

  def reject_team_request_from_user(team, user)
    @team = team
    @user = user
    mail(to: user.email, subject: 'Запрос в команду отклонён') if team.captain.email
  end
end
