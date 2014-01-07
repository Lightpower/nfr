# encoding: utf-8
module CodesHelper

  ##
  # Make HTML from results of code passing
  #
  def show_results(results)
    result = results.map { |hash|
      content_tag(
        :tr,
        content_tag(:td, content_tag(:b, content_tag(:span, hash[:data], style: "color: #{Code::STATE_COLORS[hash[:result]]}"))) +
        content_tag(:td, Code::STATE_NAMES[hash[:result]])
      )
    }
    result = content_tag(:table, result.join('').html_safe, class: 'quick_stat')
    result.html_safe
  end

  ##
  # Color code's KO if it is passed
  #
  def show_opened_code(code)
    style = "color: #{code.color || 'red'};"
    code_text = "#{code.ko}[#{code.bonus}] (#{code.show_code})"
    code_text = content_tag(:b, content_tag(:span, code_text, style: style))
    code_text += (", информация к коду:<br>#{code.info}<br>").html_safe if code.info.present?
    code_text.html_safe
  end
end
