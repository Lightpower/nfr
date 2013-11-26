# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_zone1(game)
  access_code = Code.create(number: 1, name: '', info: '', ko: 'null', game_id: game.id)
  CodeString.create(data: 'zone1', code_id: access_code.id, game_id: game.id)
  zone = Zone.create(number: 1, name: 'Зона 1', image_url: '', access_code: access_code, game_id: game.id)

  bonus = 30
  cost = -10

  # TASK
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: cost, game_id: game.id)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code, game_id: game.id)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Когда 5 исполнилось десять лет, их четверку старших начали обучать обращению с оружием.<br>
Назовите самого маленького и подвижного<br><br>

<b>Формат ответа:</b> кириллица',
                     zone: zone, code_id: access_code.id, game_id: game.id)

  add_code('шустряк', 'null', bonus, task, game)

  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: '5 – Головастик , 27 – Генерал, 21 – Палец...', game_id: game.id)

  zone.reload

  # TASK
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: cost, game_id: game.id)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code, game_id: game.id)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Відверто гадаючи, щирий справжній дебелий відьмак атакує досить натхненно, аж лишень розсипаються іскри.<br><br>

<b>Формат ответа:</b> цифры',
                     zone: zone, code_id: access_code.id, game_id: game.id)

  add_code('1223', 'null', bonus, task, game)

  Hint.create(task: task, number: 1, cost: -bonus*0.5, data: 'Откровенно Думая, Искренний Настоящий Дебелый Ведьмак...', game_id: game.id)

  zone.reload

end

##
#
def add_code(data, ko, bonus, task, game)
  code_number = task.new_code_number
  data = Unicode::downcase(data)
  code = Code.create(number: code_number, name: '', bonus: bonus, ko: ko, color: 'red', task_id: task.id, game_id: game.id)
  CodeString.create(data: data, code: code, game_id: game.id)
  task.reload
end



