# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_zone1

  access_code = Code.create(number: 1, name: '', info: '', ko: 'null')
  CodeString.create(data: 'Winter1304', code: access_code)
  zone = Zone.create(number: 1, name: 'Север', image_url: '', access_code: access_code)


  # 1 real task without access code for each zone
  task_number = zone.new_task_number
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'ул. Сивашская 12/1<br>50.432901 30.639571',
                     zone: zone)
  add_code('BD1R243', '2+', 100, task)
  add_code('BD2R516771', '3', 100, task)
  add_code('BD3R1819', '2+', 100, task)
  add_code('BD4R356', '3', 100, task)
  add_code('BD5R28', '1+', 100, task)
  add_code('BD6R7216', '3+', 100, task)
  add_code('BD7R225', '1+', 100, task)
  add_code('BD8R2756', '1+', 100, task)
  add_code('BD9R992', '1', 100, task)
  add_code('BR1D1985', '3+', 100, task)
  add_code('BD11R4196', '1+', 100, task)
  add_code('BD12R66', '2', 100, task)
  add_code('BD13R73', '1+', 100, task)
  add_code('BD14R77', '3+', 100, task)
  add_code('BD15R', '1+', 100, task)
  add_code('BD16R51', '3+', 100, task)
  add_code('BD17R63', '1', 100, task)
  add_code('BD18R51', '1', 100, task)
  add_code('BD19R714', '2', 100, task)
  add_code('BR2D384', '1', 100, task)
  add_code('BD21R21', '1', 100, task)
  add_code('BD22R33', '1', 100, task)
  add_code('BD23R3', '1+', 100, task)
  add_code('BD24R41', '1', 100, task)
  add_code('BD25R3837', '1', 100, task)
  add_code('BD26R6629', '2', 100, task)
  add_code('BD27R78586', '1', 100, task)
  add_code('BD28R838', '2+', 100, task)
  add_code('BD29R92', '1', 100, task)
  add_code('BR3D6571', '1', 100, task)

  zone.reload

  # Closed task
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: -500)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'ул. Сивашская 12/1<br>50.432901 30.639571',
                     zone: zone,
                     access_code: access_code)
  add_code('BD1R452', '2', 100, task)
  add_code('BD2R3189', '1+', 100, task)
  add_code('BD3R7', '1+', 100, task)
  add_code('BD4R222', '1+', 100, task)
  add_code('BD5R8185', '2', 100, task)
  add_code('BD6R31947', '1+', 100, task)
  add_code('BD7R911', '1+', 100, task)
  add_code('BD8R1111', '1+', 100, task)
  add_code('BD9R733', '1+', 100, task)
  add_code('BD10R8338', '1', 100, task)

  zone.reload


  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Брану во сне приснилась ворона с третьим глазом. Она сказала: "Сегодня утром сын Роберта приказал последний раз казнить Эддарда Старка: "Отрубить Старку голову."<br><br><b>Формат ответа:</b> кириллица, два слова',
                     zone: zone)
  add_code('Рикон Старк', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'СЛОВА вороны с ТРЕТЬИМ глазом часто очень загадочны.')
  Hint.create(task: task, number: 2, cost: -bonus*0.3, data: 'Брану во сне приснилась ворона с третьим глазом. Она сказала: "Бран, тебе НУЖНО читать каждое ТРЕТЬЕ письмо. Тогда СЛОВО получишь".')
  zone.reload

  # VIRTUAL - РЕЧНЫЕ заМЛИ
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Их в тот день было одиннадцать<br>
Первому - отрезали голову, второй - перерезали горло, третий - застрелен из арбалета, четвертый был зарублен, защищая короля, пятая - убита топором в живот, шестой - заколот, седьмой и восьмой - застрелены из арбалета, девятый - зарублен шестым сыном, десятый - застрелен из арбалета.<br>
Кто же был одиннадцатым, если он не человек?<br><br>
<b>Формат ответа:</b> кириллица, два слова через пробел
',
                     zone: zone)
  add_code('Серый Ветер', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'Эта свадьба закончилась не "они жили долго и счастливо".')
  Hint.create(task: task, number: 2, cost: -bonus*0.3, data: 'Брану во сне приснилась ворона с третьим глазом. Она сказала: "Бран, тебе НУЖНО читать каждое ТРЕТЬЕ письмо. Тогда СЛОВО получишь".')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'У него было много профессий. Сначала он возводил здания, потом бороздил морские просторы, а позже стал носителем символа Олимпиады.<br>
Назовите его имя и фамилию.<br><br>
<b>Формат ответа:</b> кириллица, два слова через пробел
',
                     zone: zone)
  add_code('Брандон Старк', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.5, data: 'Строитель, мореплаватель, факельщик.')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Мы помним: мудрость и сила днем или ночью всегда получит свое. Без отдыха правда побеждает!<br><br>

<img src=\'http://fs137.www.ex.ua/get/52207170/52096094.png\'>

<b>Формат ответа:</b> кириллица и цифры, два слова и шесть цифр (именно в таком порядке) без пробелов.<br>
Шесть цифр - это те цифры, по которым вы рагадаете первые два слова (имя и фамилию)
',
                     zone: zone)
  add_code('БрандонСтарк261283', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'Девиз и цвет флага укажут 6 цифр слева направо')
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'Цифры - это годы жизни')
  zone.reload

  # Kubraya
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: "чин кичтел<br>
хи яьмес<br>
разрешению пшеница<br>
окрик преследование<br>
luch шахматы<br>
перед шосс саввина<br><br>
Перед каждым ответом вводите #{zone.id}#{task_number}, например - #{zone.id}#{task_number}кубрай",
                     zone: zone)

  add_code('санса', 'null', bonus, task)
  add_code('сандор', 'null', bonus, task)
  add_code('визерис', 'null', bonus, task)
  add_code('эйгон', 'null', bonus, task)
  add_code('рейго', 'null', bonus, task)
  add_code('дотракия', 'null', bonus, task)

  zone.reload

end

##
#
def add_code(data, ko, bonus, task)
  code_number = task.new_code_number
  code = Code.create(number: code_number, name: '', bonus: bonus, ko: ko, color: 'red', task_id: task.id)
  CodeString.create(data: data, code: code)
  task.reload
end