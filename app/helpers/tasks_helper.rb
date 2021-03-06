# encoding: UTF-8
module TasksHelper

  ##
  # Show preview for not allowed tasks
  #
  def show_preview(task)
    result = task.preview.present? ? task.preview + '<br>' : ''
    result << "Код доступа к заданию: <b>#{task.access_code.show_code}</b>" if task.preview.blank?
    result << "<br>Стоимость задания: #{- task.access_code.try(:bonus)} очков. В задании есть:"
    result << "<br>- реальных кодов: #{task.codes.where("ko != 'null'").size}"
    result << "<br>- виртуальных кодов: #{task.codes.where(ko: 'null').size}"
    result << "<br>- вложенных заданий: #{task.tasks.size}"
    result
  end
end
