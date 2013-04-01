# encoding: UTF-8
module TasksHelper

  ##
  # Show preview for not allowed tasks
  #
  def show_preview(task)
    result = task.preview
    result << "<br>Код доступа к заданию: #{task.access_code.code_strings.map(&:data).join(", ")}"
    result << "<br>Стоимость задания: #{- task.access_code.try(:bonus)} кодов. В задании есть:"
    result << "<br>- реальных кодов: #{task.codes.where("ko != 'null'").size}"
    result << "<br>- виртуальных кодов: #{task.codes.where(ko: 'null').size}"
    result << "<br>- вложенных заданий: #{task.tasks.size}"
    result
  end
end
