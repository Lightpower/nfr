class MassMailsJob

  def self.perform(mail_id)
    mail = Mailout.find(mail_id)
    MassMailer.mass_send(mail).deliver if mail
  end
end