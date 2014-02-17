class MassMailsJob

  def self.perform(mail_id)
    mail = Mailout.find(mail_id)
    all_to = mail.to.split(',')
    all_to.each do |to|
      MassMailer.mass_send(mail, to).deliver if mail
    end
  end
end