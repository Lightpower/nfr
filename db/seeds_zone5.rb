# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_zone5(game)
  access_code = Code.create(number: 1, name: '', info: '', ko: 'null', game_id: game.id)
  CodeString.create(data: 'zone5', code_id: access_code.id, game_id: game.id)
  zone = Zone.create(number: 5, name: 'Зона 5', image_url: '', access_code: access_code, game_id: game.id)

  bonus = 10
  cost = -10

  # TASK
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: cost, game_id: game.id)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code, game_id: game.id)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: '“Помни. Брать с собой нужно вовсе не то, что может когда-нибудь пригодиться, а лишь то, без чего никак не обойтись.”<br>
 Геральт заставлял ученицу перепаковывать рюкзачок трижды и лишь после этого остался доволен.<br><br>

Какие пункты были необходимостью при походе?<br><br>

<b>Формат каждого ответа:</b> кириллица',
                     zone: zone, code_id: access_code.id, game_id: game.id)

  add_code('Ноутбук и мобильник', 'null', bonus, task, game)
  add_code('Оружие', 'null', bonus, task, game)
  add_code('Аптечка', 'null', bonus, task, game)
  add_code('Предметы гигиены', 'null', bonus, task, game)

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



