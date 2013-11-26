# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_zone0(game)
  bonus = 10
  task_number = 0

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: "#{add_formuls}<br>

<b>Формат каждого ответа:</b> название исторической местности или объекта в Киеве, кириллица, одно или больше слов.",
                     game_id: game.id)
  add_code('Пирогов', 'null', 15, task, game)
  add_code('ипподром', 'null', 15, task, game)
  add_code('пейзажная аллея', 'null', 15, task, game)
  add_code('Площадь Дружбы Народов', 'null', 15, task, game)
  add_code('дом с химерами', 'null', 15, task, game)
  add_code('ВДНХ', 'null', 15, task, game)
  add_code('Нос Гоголя', 'null', 15, task, game)
  add_code('Национальный цирк Украины', 'null', 15, task, game)
  add_code('Подол', 'null', 15, task, game)
  add_code('Золотые ворота', 'null', 15, task, game)
  add_code('Парк Дружбы народов', 'null', 15, task, game)

  ######################## Cities
  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(1),
                     game_id: game.id)
  add_code('462800304400', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Жемчужина у моря.', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(2),
                     game_id: game.id)
  add_code('484200442900', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -12, data: 'Волга в град', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(3),
                     game_id: game.id)
  add_code('471400394300', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -12, data: 'Остров на Доне', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(4),
                     game_id: game.id)
  add_code('541200373700', 'null', 8, task, game)
  Hint.create(task: task, number: 1, cost: -4, data: 'Dva ла', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(5),
                     game_id: game.id)
  add_code('531200450000', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Пористое вулканическое стекло', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(6),
                     game_id: game.id)
  add_code('560800402500', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Имя', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(7),
                     game_id: game.id)
  add_code('553421420305', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Кем? Чем?', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(8),
                     game_id: game.id)
  add_code('543700394300', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Циолковский, Мичурин, Есенин, Салтыков-Щедрин', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: "Актау, Уральск, Актобе, Астрахань, Сыктывкар, Ашдод, Абердин<br><br>

<b>Формат ответа:</b> координаты города согласно Wikipedia в формате ГГММССГГММСС (сначала широта, потом долгота)",
                     game_id: game.id)
  add_code('470700515300', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Побратимы', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(10),
                     game_id: game.id)
  add_code('544400555800', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Три шурупа', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: "837831 живых<br><br>

<b>Формат ответа:</b> координаты города согласно Wikipedia в формате ГГММССГГММСС (сначала широта, потом долгота)",
                     game_id: game.id)
  add_code('513200460000', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Население', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(12),
                     game_id: game.id)
  add_code('550900612400', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Три шурупа', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: "Крепость Ё<br><br>

<b>Формат ответа:</b> координаты города согласно Wikipedia в формате ГГММССГГММСС (сначала широта, потом долгота)",
                     game_id: game.id)
  add_code('565000603500', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Бург', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: "Центр: пр-т Юрия Гагарина, 21а <br><br>

<b>Формат ответа:</b> координаты города согласно Wikipedia в формате ГГММССГГММСС (сначала широта, потом долгота)",
                     game_id: game.id)
  add_code('570900653200', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Чья?', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(15),
                     game_id: game.id)
  add_code('443600333200', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -5, data: 'человек с деревом', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(16),
                     game_id: game.id)
  add_code('480032374815', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'лимон = 1000000', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(17),
                     game_id: game.id)
  add_code('590800375500', 'null', 8, task, game)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(18),
                     game_id: game.id)
  add_code('570000405900', 'null', 10, task, game)
  Hint.create(task: task, number: 1, cost: -5, data: 'город невест', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(19),
                     game_id: game.id)
  add_code('561400432700', 'null', 10, task, game)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(20),
                     game_id: game.id)
  add_code('643300403200', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'треска, доска и тоска', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(21),
                     game_id: game.id)
  add_code('562919845708', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'том, ВЛ20', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(22),
                     game_id: game.id)
  add_code('595700301900', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'терпи', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(23),
                     game_id: game.id)
  add_code('502440801339', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'Торговая, Оружейная, Грановитая, Общественная, Общин, Лордов, Счетная', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(24),
                     game_id: game.id)
  add_code('561937440027', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'НиНо Катамадзе', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(25),
                     game_id: game.id)
  add_code('531100500700', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -8, data: 'SturmAbteilung, 16-я буква тибетского алфавита, верховное египетское божество', game_id: game.id)

  # VIRTUAL
  task_number += 1
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: rebus_city(26),
                     game_id: game.id)
  add_code('604233284439', 'null', 16, task, game)
  Hint.create(task: task, number: 1, cost: -12, data: 'Выбираем букву Г', game_id: game.id)
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

def add_formuls
  ret = ''
  11.times do |i|
    ret += "<p><img src=\"http://arzamas-16.org/files/formuly/Formula-10-#{i+1}.png\"></p>"
  end
  ret
end

def rebus_city(i)
  "<p><img src=\"http://arzamas-16.org/files/rebusy/zad-20-#{i}.jpg\"></p> <b>Формат ответа:</b> координаты города согласно Wikipedia в формате ГГММССГГММСС (сначала широта, потом долгота)"
end

def add_rebuses
  ret = ''
  6.times do |i|
    ret += "<p><img src=\"http://arzamas-16.org/files/reb2/#{i+1}.jpg\"></p>"
  end
  ret
end