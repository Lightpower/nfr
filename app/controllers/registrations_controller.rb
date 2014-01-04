class RegistrationsController < Devise::RegistrationsController

  def create
    super
    UserMailer.welcome(@user).deliver if @user.valid?
  end

end