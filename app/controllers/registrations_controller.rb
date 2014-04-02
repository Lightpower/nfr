class RegistrationsController < Devise::RegistrationsController

  def create
    params[:user][:domain_id] ||= Domain.all.first.id
    super
    UserMailer.welcome(@user).deliver if @user.valid?
  end

end