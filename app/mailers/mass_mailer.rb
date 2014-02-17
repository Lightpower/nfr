# encoding: UTF-8
class MassMailer < ActionMailer::Base
  default from: 'support@nfr.kiev.ua'

  def mass_send(instance, to)
    from = instance.from
    subject = instance.subject
    body = instance.body
    if instance.attachments
      instance.attachments.split(',').each do |file_path|
        attachment[file_path.split('/').last] = File.read(file_path)
      end
    end

    mail(from: from,
         to: to,
         subject: subject,
         body: body,
         content_type: 'text/html')

    instance.sent_at = Time.now
    instance.save
  end

end
