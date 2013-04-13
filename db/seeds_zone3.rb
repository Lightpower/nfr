# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PRICE = {"1" => 240, "1+" => 94, "2" => 550, "2+" => 267, "3" => 70, "3+" => 50}

def create_zone3
  access_code = Code.create(number: 1, name: '', info: '', ko: 'null')
  CodeString.create(data: 'Storm12', code_id: access_code.id)
  zone = Zone.create(number: 3, name: 'Штормовые Земли', image_url: '', access_code: access_code)


  # 1 real task without access code for each zone
  task_number = zone.new_task_number
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Ул. Вишняковская, 6 <br>50.394546 30.651094<br><br>
<b>Примечание</b><br>
Заход по меткам. Играет всё, что выше метки DR Start.',
                     zone: zone)
  add_code('BD1R172', '3+', 100, task)
  add_code('BD2R487', '3', 100, task)
  add_code('BD3R88', '3', 100, task)
  add_code('BD4R76823', '1+', 100, task)
  add_code('BD5R27', '1+', 100, task)
  add_code('BD6R49', '1', 100, task)
  add_code('BD7R4312', '2+', 100, task)
  add_code('BD8R1212', '2+', 100, task)
  add_code('BD9R2142168418', '1+', 100, task)
  add_code('BR1D427', '2+', 100, task)
  add_code('BD11R7891', '1', 100, task)
  add_code('BD12R73', '1+', 100, task)
  add_code('BD13R8424', '1', 100, task)
  add_code('BD14R23', '1+', 100, task)
  add_code('BD15R7841', '1+', 100, task)
  add_code('BD16R44', '1+', 100, task)
  add_code('BD17R4522', '1+', 100, task)
  add_code('BD18R7229', '1+', 100, task)
  add_code('BD19R74', '1+', 100, task)
  add_code('BR2D7142874', '1+', 100, task)
  add_code('BD21R24', '1+', 100, task)
  add_code('BD22R142', '1+', 100, task)
  add_code('BD23R42', '2', 100, task)
  add_code('BD24R223', '1', 100, task)
  add_code('BD25R7789211', '1+', 100, task)
  add_code('BD26R272985', '1', 100, task)
  add_code('BD27R481', '1+', 100, task)
  add_code('BD28R421', '1+', 100, task)
  add_code('BD29R772', '1+', 100, task)
  add_code('BR3D74', '1+', 100, task)
  zone.reload

  # Closed task
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: -500)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Быки моста<br>
Пересечение ул. Причальной и ул. Днепровской, 150 метров южнее и ближе к реке.<br>
<br>
<b>Примечание</b><br>
Заход только по меткам с южной стороны!!! Не шуметь, без лишней необходимости наружу не светить. ',
                     zone: zone,
                     access_code: access_code)
  add_code('BD1R', '3+', 100, task)
  add_code('BD2R228311', '3', 100, task)
  add_code('BD3R99558', '3+', 100, task)
  add_code('BD4R768', '3+', 100, task)
  add_code('BD5R11', '3+', 100, task)
  add_code('BD6R2184', '3+', 100, task)
  add_code('BD7R2986', '3', 100, task)
  add_code('BD8R1215', '3+', 100, task)
  add_code('BD9R17', '3+', 100, task)
  add_code('BD10R101010', '3', 100, task)

  zone.reload

  #####################################################
  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 300
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Сын неудачника, он женился вопреки традициям. Какое великое здание построил его возлюбленный младший брат?<br><br>
<b>Формат ответа:</b> кириллица, три слова через пробел',
                     zone: zone)
  add_code('Великая септа Бейлора', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'Ну и семейка - Неудачник, Мальчик и Благословенный.')
  Hint.create(task: task, number: 2, cost: -bonus*0.3, data: 'Это здание в Королевской Гавани потом было названо в его честь.')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 300
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Всё, чего не хватает этому миру:  справедливости и милосердия, храбрости и мудрости, трудолюбия и чистоты - могли дать они. Но это мог подарить только он. Кто он?<br><br>
<b>Формат ответа:</b> Слово кириллицей в именительном падеже маленькими буквами',
                     zone: zone)
  add_code('Неведомый', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'А было их всего семеро.')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'И боров, жирный как король,<br>
И гривой густой наделён.<br>
Взойду я за братом на трон,<br>
И ветер — словно их зов.<br><br>

Отец на небе, грозный бог<br>
Бежит, дрожит земля,<br>
Он светел, и ясен, и ликом прекрасен -<br>
Гони нас на восток.<br><br>

Чёрную думу лелеет,<br>
Но если когти твои остры,<br>
Чёрная ненависть зреет -<br>
Хозяйка её пострашнее войны.<br><br>

Ответ - официальное название, кириллица',
                     zone: zone)
  add_code('Бравые ребята', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: '<a href=\'http://goo.gl/qyLyq\'>http://goo.gl/qyLyq</a>')
  Hint.create(task: task, number: 2, cost: -bonus*0.3, data: 'Каждая строка - из одной <a href=\'http://7kingdoms.ru/wiki/%D0%9A%D0%B0%D1%82%D0%B5%D0%B3%D0%BE%D1%80%D0%B8%D1%8F:%D0%9F%D0%B5%D1%81%D0%BD%D0%B8\'>песни</a>')
  zone.reload


  # Kubraya
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number} - Кубраи",
                     data: "бег ар<br>
бутса брюс<br>
август соснн<br>
мишень протон<br>
лампа нилиф<br>
покойницкая ущом<br><br>
Перед каждым ответом вводите #{zone.id}#{task_number}, например - <b>#{zone.id}#{task_number}кубрай</b>",
                     zone: zone)

  add_code("#{zone.id}#{task_number}шагга", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}ботли", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}мартелл", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}тирион", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}браавос", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}моргулис", 'null', bonus, task)

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


