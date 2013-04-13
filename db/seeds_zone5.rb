# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PRICE = {"1" => 600, "1+" => 89, "2" => 183, "2+" => 80, "3" => 175, "3+" => 200}

#[600.0, 89.47368421052632, 183.33333333333334, 80.0, 175.0, 200.0]

def create_zone5
  access_code = Code.create(number: 1, name: '', info: '', ko: 'null')
  CodeString.create(data: 'WhiteEagle', code_id: access_code.id)
  zone = Zone.create(number: 5, name: 'Долина Аррен', image_url: '', access_code: access_code)


  # 1 real task without access code for each zone
  task_number = zone.new_task_number
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'ул. Бабушкина 28<br>
50.461346 30.413514<br><br>
<b>Примечание</b>
Вход с тыльной стороны здания. Играет 1-й этаж (внутри) и чердак. В окна соседних домов не светить. По лестнице с наружной стороны здания подниматься без фонарей.
',
                     zone: zone)

  add_code('BD1R423', '2+', 100, task)
  add_code('BD2R248', '1+', 100, task)
  add_code('BD3R999', '3+', 100, task)
  add_code('BD4R821', '1+', 100, task)
  add_code('BD5R426', '1+', 100, task)
  add_code('BD6R8119', '1', 100, task)
  add_code('BD7R8452', '3', 100, task)
  add_code('BD8R749', '2+', 100, task)
  add_code('BD9R473', '2+', 100, task)
  add_code('BD10R334', '1+', 100, task)
  add_code('BD11R1111', '2+', 100, task)
  add_code('BD12R43', '3+', 100, task)
  add_code('BD13R997', '1+', 100, task)
  add_code('BD14R274', '3', 100, task)
  add_code('BD15R77', '1+', 100, task)
  add_code('BD16R22', '2+', 100, task)
  add_code('BD17R82', '1+', 100, task)
  add_code('BD18R141', '1+', 100, task)
  add_code('BD19R4553', '1', 100, task)
  add_code('BD20R494', '2+', 100, task)
  add_code('BD21R7788', '1+', 100, task)
  add_code('BD22R521', '1+', 100, task)
  add_code('BD23R17', '1+', 100, task)
  add_code('BD24R7', '2', 100, task)

  zone.reload

  # Closed task
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: -500)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'ул. Салютная, 40<br>
50.471771 30.420917<br><br>
<b>Примечание</b>
Играет только подвал. Вход на локацию с правой стороны здания. Фонари включать уже в подвале. Не шуметь.',
                     zone: zone,
                     access_code: access_code)
  add_code('BD1R425', '1+', 100, task)
  add_code('BD2R1111', '2+', 100, task)
  add_code('BD3R487', '1+', 100, task)
  add_code('BD4R8221', '1+', 100, task)
  add_code('BD5R121', '1+', 100, task)
  add_code('BD6R77', '1+', 100, task)
  add_code('BD7R3556', '1+', 100, task)
  add_code('BD8R59821', '1+', 100, task)
  add_code('BD9R222', '2+', 100, task)
  add_code('BD10R12', '2+', 100, task)
  add_code('BD11R11311', '1+', 100, task)
  add_code('BD12R584', '2', 100, task)
  add_code('BD13R3691', '2+', 100, task)
  add_code('BD14R3221', '2', 100, task)

  zone.reload


  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 300
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: '<br><br>Певица вышла замуж за Зяблика, но свою фамилию оставила, добавив к ней фамилию мужа. Как её зовут по имени-отчеству?
<b>Формат ответа:</b> кириллица, два слова',
                     zone: zone)
  add_code('Лариса Александровна', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'Загадка-шутка.<br>Её новая фамилия очень гармонирует с королевством, которым она теперь правит.')
  Hint.create(task: task, number: 2, cost: -bonus*0.4, data: 'Новая фамилия - Долина-Аррен')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 300
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'За сколько полных монет можно купить немого, рыцаря и ученика? Где найти эти монеты?<br><br>
<b>Формат ответа:</b> цифры и слово кириллицей (начальная форма) без пробела. Например, 123пример
',
                     zone: zone)
  add_code('18герб', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'Их боль попробуйте посчитать на страничке в википедии.')
  Hint.create(task: task, number: 2, cost: -bonus*0.3, data: 'Количество видно невооруженным взглядом на поле в белую и пурпурную клетку.')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Jin Мaegi fich h\'anhaan athdrivar.<br><br>
<b>Формат ответа:</b> три слова через пробел, кириллица
',
                     zone: zone)
  add_code('Мирри Маз Дуур', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'Простите мне мой суржик, я впервые за Узким морем')
  Hint.create(task: task, number: 2, cost: -bonus*0.3, data: 'Дотракийский язык')
  zone.reload


  # Kubraya
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number} - Кубраи",
                     data: "бес ытамхаш<br>
пяте языкец<br>
лосси пари т<br>
красно лимфная<br>
стар герда<br>
полщуки король<br><br>
Перед каждым ответом вводите #{zone.id}#{task_number}, например - <b>#{zone.id}#{task_number}кубрай</b>",
                     zone: zone)

  add_code("#{zone.id}#{task_number}чертог", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}трезубец", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}ланниспорт", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}зеленокровная", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}юнкай", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}рыцарь", 'null', bonus, task)

  zone.reload

end

##
#
def add_code(data, ko, bonus, task)
  code_number = task.new_code_number
  bonus = PRICE[ko] if ko != "null"
  code = Code.create(number: code_number, name: '', bonus: bonus, ko: ko, color: 'red', task_id: task.id)
  CodeString.create(data: data, code: code)
  task.reload
end


