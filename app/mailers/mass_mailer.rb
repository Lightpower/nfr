# encoding: UTF-8
class MassMailer < ActionMailer::Base
  default from: 'support@nfr.kiev.ua'

  def mass_send(instance)
    from = instance.from
    all_to = instance.to.split(',')
    # TODO: remove testing
    all_to = ['vitaly.beskrovny@gmail.com', 'nedostroy@gmail.com', 'v.italybeskrovny@gmail.com']
    subject = instance.subject
    body = instance.body
    if instance.attachments
      instance.attachments.split(',').each do |file_path|
        attachment[file_path.split('/').last] = File.read(file_path)
      end
    end

    all_to.each do |to|
      mail(from: from,
           to: to,
           subject: subject,
           body: body,
           content_type: 'text/html')
    end

    instance.sent_at = Time.now
    instance.save
  end

end
