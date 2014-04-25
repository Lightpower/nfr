##
# Create code
#
def add_code(data, ko, bonus, task, game, info=nil)
  code_number = task.try(:new_code_number) || 0
  data = Array.wrap(data)
  data.map! { |d| Unicode::downcase(d) }
  code = Code.create(number: code_number, name: '', bonus: bonus, ko: ko, color: 'blue', task_id: task.try(:id), game_id: game.id, info: info)
  data.each do |d|
    CodeString.create(data: d, code: code, game_id: game.id)
  end
  task.reload if task

  code
end

def img_tag(filename)
  "<img src=\"http://klads.org.ua/nfr/007/#{filename}\">"
end
