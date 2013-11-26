# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_zone4(game)
  access_code = Code.create(number: 1, name: '', info: '', ko: 'null', game_id: game.id)
  CodeString.create(data: 'zone4', code_id: access_code.id, game_id: game.id)
  zone = Zone.create(number: 4, name: 'Зона 4', image_url: '', access_code: access_code, game_id: game.id)

  bonus = 100
  cost = -10

  # TASK
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: cost, game_id: game.id)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code, game_id: game.id)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Помогите восстановить начальную схему<br>
<p><img src=\"http://arzamas-16.org/files/square_1.jpg\"></p>

<b>Формат ответа:</b> слово, кириллица',
                     zone: zone, code_id: access_code.id, game_id: game.id)

  add_code('Леха', 'null', bonus, task, game)

  Hint.create(task: task, number: 2, cost: -bonus*0.4, data: 'Соберите головоломку - желтый к желтому, красный к красному и т.д. Край головоломки – серого цвета. Послание начинайте читать из центра.', game_id: game.id)

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



