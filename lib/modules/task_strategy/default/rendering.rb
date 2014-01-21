# encoding: UTF-8
##
# Standard elements rendering for Task Strategy
#
module TaskStrategy
  module Default
    module Rendering

      include ActionView::Helpers::TagHelper

      ##
      # Make Code block for task
      #
      # Params:
      # - params {Hash} - params with :task, :user, :last_result
      #
      def codes_block(params)
        task = params[:task]
        user = params[:user]
        last_result = params[:last_result]

        (
        '<b>Коды:</b> ' + task.codes.by_order.map{|code| codes_html(code, user.team.id, last_result)}.join(', ')
        ).html_safe
      end

      private

      ##
      # Color code's KO if it is passed
      #
      def codes_html(code, team_id, last_result=nil)
        ko_price = "#{code.ko}[#{code.bonus}]"
        team_code = TeamCode.where(code_id: code.id, team_id: team_id, state: [Code::STATES.index(:accepted), Code::STATES.index(:accessed)]).first
        if team_code.present?
          style = "color: #{code.color || 'red'};"
          style << "border: 2px inset red;" if last_result.present? && last_result.select {|i| i[:id] == code.id}.present?
          code_text = ko_price
          code_text += "(#{code.show_code})" if team_code.team_bonus.blank?
          code_text = content_tag(:b, content_tag(:span, code_text, style: style).html_safe)
          code_text += ("<br>#{code.info}<br>").html_safe if code.info.present?
          code_text.html_safe
        else
          content_tag(:span, "#{ko_price}", class: 'ko', 'data-id' => code.id).html_safe
        end
      end

      ##
      # Color code's KO if it is passed
      #
      def show_opened_code(code)
        style = "color: #{code.color || 'red'};"
        code_text = "#{code.ko}[#{code.bonus}] (#{code.show_code})"
        code_text = content_tag(:b, content_tag(:span, code_text, style: style))
        code_text += (", информация к коду: <br>#{code.info}<br>").html_safe if code.info.present?
        content_tag(:div, code_text.html_safe)
      end
    end
  end
end