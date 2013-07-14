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
  def ko_colored(code, team_id, last_result=nil)
    ko_price = "#{code.ko}[#{code.bonus}]"
    team_code = TeamCode.where(code_id: code.id, team_id: team_id, state: Code::STATES.index(:accepted)).first
    if team_code.present?
      style = "color: #{code.color || 'red'};"
      style << "border: 2px inset red;" if last_result.present? && last_result.select {|i| i[:id] == code.id}.present?
      code_text = ko_price
      code_text += "(#{code.show_code})" if team_code.team_bonus.blank?
      content_tag(:b, content_tag(:span, code_text, style: style).html_safe).html_safe
    else
      content_tag(:span, "#{ko_price}", class: 'ko', 'data-id' => code.id).html_safe
    end
  end
end
