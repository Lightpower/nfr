# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_zone2(game)
  access_code = Code.create(number: 1, name: '', info: '', ko: 'null', game_id: game.id)
  CodeString.create(data: 'zone2', code_id: access_code.id, game_id: game.id)
  zone = Zone.create(number: 2, name: 'Зона 2', image_url: '', access_code: access_code, game_id: game.id)

  bonus = 30
  cost = -10
  # VIRTUAL
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: cost, game_id: game.id)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code, game_id: game.id)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: '<p><img src="http://arzamas-16.org/files/task_7_sl.png"></p>

На картинке изображено 7 словосочетаний, состоящих  каждое из двух слов. Ваша задача - соединить подходящие попарно согласно тематике. Одно из слов в паре является прилагательным, второе - существительным.<br>
Например: Трава+чай= травяной чай<br><br>
<b>Формат ответа:</b> словосочетание, кириллица (по два слова)',
                     zone: zone, code_id: access_code.id, game_id: game.id)

  add_code('помповое ружье', 'null', bonus, task, game)
  add_code('химический комбинат', 'null', bonus, task, game)
  add_code('охранный комплекс', 'null', bonus, task, game)
  add_code('легкая формула', 'null', bonus, task, game)
  add_code('черная хортица', 'null', bonus, task, game)
  add_code('дикий броненосец', 'null', bonus, task, game)
  add_code('мятый диск', 'null', bonus, task, game)
  Hint.create(task: task, number: 1, cost: -60, data: 'слева направо по цепочке: помпа, комбинат, актер какого-то сериала, некая дыра,  мятый лист,сами знаете кто, явно понятная наука, украинская водка, броненосец, формула, некое оружие, диск, програмный КОМПЛЕКС и ужасного состояния орган.', game_id: game.id)
  zone.reload

end

##
#
def add_code(data, ko, bonus, task, game)
  code_number = task.new_code_number
  bonus = PRICE[ko] if ko != "null"
  data = Unicode::downcase(data)
  code = Code.create(number: code_number, name: '', bonus: bonus, ko: ko, color: 'red', task_id: task.id, game_id: game.id)
  CodeString.create(data: data, code: code, game_id: game.id)
  task.reload
end



