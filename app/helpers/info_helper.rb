module InfoHelper
  def contact(name, phone, skype, email, extra={})
    result = ''

    result << content_tag(:tr,
      content_tag(:td, content_tag(:b, 'Телефон:')) +
      content_tag(:td, phone)
    ) if phone

    result << content_tag(:tr,
                          content_tag(:td, content_tag(:b, 'Skype:')) +
                            content_tag(:td, skype)
    ) if skype

    result << content_tag(:tr,
                          content_tag(:td, content_tag(:b, 'E-mail:')) +
                            content_tag(:td, email)
    ) if email

    extra.each_pair do |key, val|
      result << content_tag(:tr,
                            content_tag(:td, content_tag(:b, key)) +
                              content_tag(:td, val)
      )
    end

    result = content_tag(:table, result.html_safe)

    result = content_tag(:span, name, class: 'contact_name') + result

    content_tag(:div, result, class: 'contact_block')
  end
end
