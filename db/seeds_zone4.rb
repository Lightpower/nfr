# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PRICE = {"1" => 300, "1+" => 89, "2" => 110, "2+" => 133, "3" => 116, "3+" => 133}

#[300.0, 89.47368421052632, 110.0, 133.33333333333334, 116.66666666666667, 133.33333333333334]

def create_zone4
  access_code = Code.create(number: 1, name: '', info: '', ko: 'null')
  CodeString.create(data: 'Gold777', code_id: access_code.id)
  zone = Zone.create(number: 4, name: 'Замковый Утёс', image_url: '', access_code: access_code)


  # 1 real task without access code for each zone
  task_number = zone.new_task_number
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'ул. Красноткацкая, 280 метров от пересечения Красноткацкой и Магнитогорской<br>
50.457678 30.641990<br>
<b>Примечание</b><br>
На локации не шуметь. В сторону соседних территорий не светить.',
                     zone: zone)
  add_code('BD1R171', '3', 100, task)
  add_code('BD2R734', '1+', 100, task)
  add_code('BD3R817', '3', 100, task)
  add_code('BD4R1', '1+', 100, task)
  add_code('BD5R12', '1+', 100, task)
  add_code('BD6R111', '1+', 100, task)
  add_code('BD7R739', '3', 100, task)
  add_code('BD8R4396', '1', 100, task)
  add_code('BD9R9612', '1+', 100, task)
  add_code('BR1D213', '1+', 100, task)
  add_code('BD11R739', '2', 100, task)
  add_code('BD12R48', '1', 100, task)
  add_code('BD13R', '1+', 100, task)
  add_code('BD14R85', '1+', 100, task)
  add_code('BD15R341277', '1+', 100, task)
  add_code('BD16R3412', '1+', 100, task)
  add_code('BD17R7411', '3+', 100, task)
  add_code('BD18R43', '1+', 100, task)
  add_code('BD19R8', '2+', 100, task)
  add_code('BR2D14', '1+', 100, task)
  add_code('BD21R9161', '1+', 100, task)
  add_code('BD22R3911', '2', 100, task)
  add_code('BD23R443', '1', 100, task)
  add_code('BD24R3714', '1+', 100, task)
  add_code('BD25R521', '2+', 100, task)
  add_code('BD26R611', '3+', 100, task)
  add_code('BD27R4895', '1+', 100, task)
  add_code('BD28R1943', '2+', 100, task)
  add_code('BD29R1585', '3+', 100, task)
  add_code('BR3D41172667', '1', 100, task)

  zone.reload

  # Closed task
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: -500)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Школьная теплица. Юго-западней ул. Космонавта Волкова, 20<br>
50.486566 30.639367',
                     zone: zone,
                     access_code: access_code)
  add_code('BD1R1743', '2+', 100, task)
  add_code('BD2R73', '1+', 100, task)
  add_code('BD3R618', '2', 100, task)
  add_code('BD4R27', '1+', 100, task)
  add_code('BD5R351', '2', 100, task)
  add_code('BD6R4134', '2', 100, task)
  add_code('BD7R1111', '2+', 100, task)
  add_code('BD8R1', '1+', 100, task)
  add_code('BD9R794', '1+', 100, task)
  add_code('BR1D311', '2+', 100, task)

  zone.reload


  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'В детстве Бес любил раскрашивать картинки. Индейца он раскрашивал оранжевым, кита - желтым, большого пса - белым. А кого он раскрашивал в красный, если он ближе всех?<br><br>
<b>Формат ответа:</b> кириллица, одно слово, именительный падеж
',
                     zone: zone)
  add_code('кентавр', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'Гори-гори, моя маленькая звезда')
  Hint.create(task: task, number: 2, cost: -bonus*0.3, data: 'Какое звёздное карликовое животное ближе всех?')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 400
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: "На гбере огдноо из вликеих доомв Втресореса ибозорбёжн злооотй лев на ксонмрам плое. Кукаю чтась допхеса вы удивуите, пянов, что я иемю видву?
<b>Формат ответа:</b> кириллица, два слова через пробел
",
                     zone: zone)
  add_code('серебряный шлем', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.4, data: 'На гербе одного из великих домов Вестерроса изоббражен золотой лев на красномм поле. Какую часть доспеха вы уувидите, поняв, что я имею ввиду?')
  Hint.create(task: task, number: 2, cost: -bonus*0.4, data: 'Золотой лев изобБражен на гербе одного из великих домов ВестерРоса. Какую часть доспеха вы уУвидите, поняв, кого из их знамМеносцев я имею ввиду?')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 100
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Большой дом умника, который изгнал грызунов со скалы.<br><br>
<b>Формат ответа:</b> кириллица, одно слово
',
                     zone: zone)
  add_code('Ланнистеры', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.8, data: 'Умный шут поселился на утесе')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 300
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Правилами игры ему надлежит остаться в одиночестве, в отличии от вестеросского тёзки, который даже умер вместе с другом. "Фамилия" вестеросца на одну букву отличается от фамилии барда, написавшем четыре песни для фильма, тема которого косвенно близка теме игры. У главного героя этого фильма есть главный враг, у которого, в свою очередь, в Вестеросе есть тёзка противоположного пола. Вам же нужен отец тёзки, причём его прозвище на английском.<br><br>
<b>Формат ответа:</b> латиница, одно слово
',
                     zone: zone)
  add_code('Evenstar', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.4, data: 'Первый должен остаться лишь один, третий для фильма написал не просто песни, а четыре баллады.')
  Hint.create(task: task, number: 2, cost: -bonus*0.3, data: 'Фильм о рыцаре снят по роману Вальтера Скотта')
  zone.reload


  # Kubraya
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number} - Кубраи",
                     data: "спец сакира<br>
корлеоне талант жанейрон<br>
ого zvezdaд<br>
масса чайик или гестие осадк<br>
д krasnyj замок<br>
кафе marshrut ты<br><br>
Перед каждым ответом вводите #{zone.id}#{task_number}, например - <b>#{zone.id}#{task_number}кубрай</b>",
                     zone: zone)

  add_code("#{zone.id}#{task_number}астапор", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}дондаррион", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}бастард", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}вестерос", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}дредфорт", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}барроутон", 'null', bonus, task)

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


