##
# Standard elements rendering for Task Strategy
#
module TaskStrategy
  module Olimpian
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

        Rails.logger.info "task: #{task.id}, user: #{user.show_name}, last_result: #{last_result}"

        #begin
        #  olimpian_table(task, user.team.id, last_result).html_safe
        #rescue Exception => e
        #  "Ошибка структуры олимпийки! Поле task.special определено некорректно, task.id=#{task.id}"
        #end

        "Step 1"
      end

      private

      ##
      # Form HTML-string with codes which are placed as olimpian
      #
      def olimpian_table(task, team_id, last_result)
        struct = JSON.parse(task.special)
        #codes = {}
        #sql = "SELECT c.id, c.number, c.ko ko, c.color color, c.bonus bonus, (select data from code_strings cs where cs.code_id=c.id LIMIT 1) as data, tc.id found, tc.team_bonus_id bonus_id FROM codes c left outer join team_codes tc on (c.id=tc.code_id AND tc.team_id=#{team_id}) WHERE c.task_id=#{task.id} ORDER BY c.number"
        #pg_result = ActiveRecord::Base.connection.execute(sql)
        #pg_result.each do |row|
        #  row.merge!('just' => 1) if last_result.present? && last_result.select{|i| i[:id] == row[:id]}.present?
        #  codes.merge!(row['number'] => row.except('number'))
        #end
        #data, rowspan = define_rowspan!(struct, codes)
        #
        #'<table class="table-bordered"><tr>' + data.join('</tr><tr>') + '</tr></table>'
      end

      ##
      # Recursive define of node rowspan
      #
      def define_rowspan!(node, codes)
        data, result = [], 0
        node.each_pair do |key, val|
          if val
            subdata, rowspan = define_rowspan!(node[key], codes)
            subdata[0] += "<td rowspan=\"#{rowspan}\">#{code_html(codes[key])}</td>"
            data += subdata
            result += rowspan

          else
            data << "<td>#{code_html(codes[key])}</td>"
            result += 1
          end
        end
        [data, result]
      end

      ##
      # Color code's KO if it is passed
      #
      def code_html(code)
        ko_price = "#{code['ko']}[#{code['bonus']}]"
        if code['found']
          style = "color: #{code['color'] || 'red'};"
          style << "border: 2px inset red;" if code['just']
          code_text = ko_price
          code_text += "(#{code['data']})" if code['bonus_id'].blank?
          code_text = content_tag(:b, content_tag(:span, code_text, style: style).html_safe)
          code_text.html_safe
        else
          content_tag(:span, "#{ko_price}", class: 'ko', 'data-id' => code['id']).html_safe
        end
      end
    end
  end
end