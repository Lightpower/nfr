# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PRICE = {"1" => 240, "1+" => 85, "2" => 183, "2+" => 133, "3" => 116, "3+" => 133}

#[240.0, 85.0, 183.33333333333334, 133.33333333333334, 116.66666666666667, 133.33333333333334]
def create_zone6
  access_code = Code.create(number: 1, name: '', info: '', ko: 'null')
  CodeString.create(data: 'Fish17', code_id: access_code.id)
  zone = Zone.create(number: 6, name: 'Речные Земли', image_url: '', access_code: access_code)


  # 1 real task without access code for each zone
  task_number = zone.new_task_number
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Админздание на территории военной части<br>
50 метров юго-западней от 2-го номера по ул. Эрнста. Или не доезжая 50 - 75 метров до дома 3Б по ул. Эрнста<br>
50.415560 30.458318<br><br>
<b>Примечание</b><br>
Фонари включать только внутри локации. Вход через калитку. Если не открывается - пнуть ногой. Потом закрыть. Играют только части здания, где входы помечены метками.',
                     zone: zone)

  add_code('BD1R272', '2+', 100, task)
  add_code('BD2R2865', '1+', 100, task)
  add_code('BD3R67', '1+', 100, task)
  add_code('BD4R44791', '2+', 100, task)
  add_code('BD5R75', '1+', 100, task)
  add_code('BD6R485', '1+', 100, task)
  add_code('BD7R88', '2+', 100, task)
  add_code('BD8R234', '1+', 100, task)
  add_code('BD9R1133', '1+', 100, task)
  add_code('BD10R785', '1+', 100, task)
  add_code('BD11R', '1+', 100, task)
  add_code('BD12R9312', '1+', 100, task)
  add_code('BD13R45', '2+', 100, task)
  add_code('BD14R7685', '1+', 100, task)
  add_code('BD15R49', '2+', 100, task)
  add_code('BD16R444', '1+', 100, task)
  add_code('BD17R945', '1+', 100, task)
  add_code('BD18R1', '1+', 100, task)
  add_code('BD19R7755', '2', 100, task)
  add_code('BD20R2783', '1+', 100, task)
  add_code('BD21R4499', '1', 100, task)
  add_code('BD22R3751', '2+', 100, task)
  add_code('BD23R18185022', '1', 100, task)
  add_code('BD24R4', '1+', 100, task)
  add_code('BD25R17', '1+', 100, task)
  add_code('BD26R424', '1+', 100, task)
  add_code('BD27R7374', '2', 100, task)
  add_code('BD28R112233', '1', 100, task)
  add_code('BD29R2', '2', 100, task)
  add_code('BD30R1818', '1', 100, task)

  zone.reload

  # Closed task
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: -500)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'ул. Соломенская, 15а<br>
50.424286 30.479089<br><br>
<b>Примечание</b>
Вход только по меткам. На соседние территории не светить.',
                     zone: zone,
                     access_code: access_code)

  add_code('BD1R445', '1+', 100, task)
  add_code('BD2R8', '1+', 100, task)
  add_code('BD3R124', '1', 100, task)
  add_code('BD4R478', '1+', 100, task)
  add_code('BD5R845', '3+', 100, task)
  add_code('BD6R117', '3', 100, task)
  add_code('BD7R874', '3+', 100, task)
  add_code('BD8R4432', '3', 100, task)
  add_code('BD9R441', '3', 100, task)
  add_code('BD10R7842', '3+', 100, task)

  zone.reload


  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Стало понятно, что вторжение армии Дейнерис в Вестерос неизбежно, и все Короли Вестерроса начали к нему готовится.<br>
Станнис начал свое движение от Стены, собирая армию. Из Сумеречной башни он прошел всю Стену до Восточного дозора, потом двинулся в Винтерфел. Не задерживаясь там, отправился в Пристан. К началу вторжения он разбил лагерь со своей армией возле Дозора в Сероводье.<br>
В это время Ланнистеры двинули с Утеса Кастерли в Кракехолл, потом в Хорнваль. Оттуда они отправились в Хайгарден, но из-за проблем с обеспечением туда не дошли и остановились в Золотой роще.<br>
Дорнийцы двинулись из Солнечного дома, прошли Рогов холм, Блекмонт и пришли в Ночную песнь. Оттуда собирались через Башню радости, Королевскую гробницу и Поднебесье отправится в Виль, но после Поднебесья сбились с пути и попали в Песчаник.<br>
В это время армия Дейнерис уже находилась в Мире, готовая к отправке, но ей удалось получить под свой контроль еще несколько городов и она отправилась за их армиями. Сначала в Норвос, потом Скорби и Ни Сар. Оттуда она отправилась в Пентос, но пустынная буря задержала ее на половине пути до Гоян Дро.<br><br>
<b>Формат ответа:</b> кириллица, одно слово, не начальная форма
',
                     zone: zone)
  add_code('Фреи', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'А стояли они посреди большого яблока.')
  Hint.create(task: task, number: 2, cost: -bonus*0.3, data: 'Упали эти башни 11 сентября.')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 400
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Два исполина стояли друг напротив друга. Но пали они один за другим. Кто же был их хозяевами?<br><br>
<b>Формат ответа:</b> одно слово маленькими буквами кирилицей, начальная форма
',
                     zone: zone)
  add_code('Зима', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.5, data: 'Какой же путь прошла каждая из армий?')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Их в тот день было одиннадцать<br>
Первому - отрезали голову, второй - перерезали горло, третий - застрелен из арбалета, четвертый был зарублен, защищая короля, пятая - убита топором в живот, шестой - заколот, седьмой и восьмой - застрелены из арбалета, девятый - зарублен шестым сыном, десятый - застрелен из арбалета.<br>
Кто же был одиннадцатым, если он не человек?<br><br>

<b>Формат ответа:</b> кириллица, два слова через пробел',
                     zone: zone)
  add_code('Серый Ветер', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.5, data: 'Эта свадьба закончилась не "они жили долго и счастливо".')
  zone.reload



  # Kubraya
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number} - Кубраи",
                     data: "гельмут эй сотка<br>
супер обнаженкачка<br>
па-де-душа<br>
акабос оттенок<br>
листо права<br>
слишком лева<br><br>
Перед каждым ответом вводите #{zone.id}#{task_number}, например - <b>#{zone.id}#{task_number}кубрай</b>",
                     zone: zone)

  add_code("#{zone.id}#{task_number}кольчуга", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}вонючка", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}калека", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}септон", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}королева", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}переправа", 'null', bonus, task)

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


