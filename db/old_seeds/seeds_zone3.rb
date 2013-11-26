# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_zone3(game)
  access_code = Code.create(number: 1, name: '', info: '', ko: 'null', game_id: game.id)
  CodeString.create(data: 'zone3', code_id: access_code.id, game_id: game.id)
  zone = Zone.create(number: 3, name: 'Зона 3', image_url: '', access_code: access_code, game_id: game.id)

  bonus = 30
  cost = -10

  # TASK
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: cost, game_id: game.id)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code, game_id: game.id)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Он был вожаком самостоятельной техники, их название было не таким-то и простым, как его бортовой номер.<br>

Какое общее цифровое  название у самостоятельной техники?<br><br>

<b>Формат ответа:</b> MDRцифры (например, MDR12345)',
                     zone: zone, code_id: access_code.id, game_id: game.id)

  add_code('MDR19', 'null', bonus, task, game)

  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: '- кто ты? Я имею в виду – ты , тот кто со мной разговаривает? В каком – нибудь бункере под полигоном? – спросил Геральт<br>
- «я боевой противопехотный комплекс». Под полигоном нет бункера. С тобой разговариваю я - URMAN.', game_id: game.id)
  Hint.create(task: task, number: 2, cost: -bonus*0.6, data: 'Я. Боевой противопехотный комплекс УРМАН. Со мной нас девятеро, я и с двадцатого по двадцать седьмой.', game_id: game.id)

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



