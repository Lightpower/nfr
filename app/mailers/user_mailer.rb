class UserMailer < ActionMailer::Base
  default from: 'support@nfr.kiev.ua'

  def welcome(user)
    @user = user
    binding.pry
    mail(to: @user.email, subject: 'Добро пожаловать на сайт NeFoRmat!')
  end
end
