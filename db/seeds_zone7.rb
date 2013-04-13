# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PRICE = {"1" => 80, "1+" => 100, "2" => 550, "2+" => 800, "3" => 116, "3+" => 100.0}

#[80.0, 100.0, 550.0, 800.0, 116.66666666666667, 100.0]
def create_zone7
  access_code = Code.create(number: 1, name: '', info: '', ko: 'null')
  CodeString.create(data: 'Pirates22', code_id: access_code.id)
  zone = Zone.create(number: 7, name: 'Соль и Камень', image_url: '', access_code: access_code)


  # 1 real task without access code for each zone
  task_number = zone.new_task_number
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: '250 метров на Юг от адреса Заболотного 148<br>
или 180 метров на Восток от Метрологической 4<br>
Заезд с ул. Метрологической.<br>
50.35286 30.479186<br><br>

<b>Примечание</b>
Заезд на локацию неявный. Ориентируйтесь на башенный кран. И, да, он играет. На соседние территории не светить.',
                     zone: zone)

  add_code('BD1R99', '1', 100, task)
  add_code('BD2R483', '1+', 100, task)
  add_code('BD3R184', '1', 100, task)
  add_code('BD4R4496', '2', 100, task)
  add_code('BD5R9119', '1', 100, task)
  add_code('BD6R1', '1+', 100, task)
  add_code('BD7R2112', '1', 100, task)
  add_code('BD8R8962', '1', 100, task)
  add_code('BD9R423', '1', 100, task)
  add_code('BR1D32', '1', 100, task)
  add_code('BD11R4936', '1+', 100, task)
  add_code('BD12R7289', '1+', 100, task)
  add_code('BD13R3653', '1', 100, task)
  add_code('BD14R782', '1+', 100, task)
  add_code('BD15R1', '1+', 100, task)
  add_code('BD16R6621', '1+', 100, task)
  add_code('BD17R', '1', 100, task)
  add_code('BD18R1984', '1', 100, task)
  add_code('BD19R76', '1+', 100, task)
  add_code('BR2D7', '1+', 100, task)
  add_code('BD21R2133', '1', 100, task)
  add_code('BD22R411', '1+', 100, task)
  add_code('BD23R14', '1+', 100, task)
  add_code('BD24R183', '1+', 100, task)
  add_code('BD25R4225', '2+', 100, task)
  add_code('BD26R8', '1+', 100, task)
  add_code('BD27R888', '1+', 100, task)
  add_code('BD28R8276', '1', 100, task)
  add_code('BD29R123', '3+', 100, task)
  add_code('BR3D1861', '3', 100, task)
  add_code('BD31R2213', '3+', 100, task)
  add_code('BD32R842', '3', 100, task)
  add_code('BD33R333', '3', 100, task)

  zone.reload

  # Closed task
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: -500)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Бункер на ВДНХ. Охрана на въезде ожидает 10 грн “за работу”.<br>
50.377776 30.483429<br><br>

<b>Примечание</b>
Играет НЕ весь объект - частично центральный коридор и 2 примыкающие к нему комнаты. Меток нет. Внимательно ищем стопы. ',
                     zone: zone,
                     access_code: access_code)

  add_code('BD1R721', '1+', 100, task)
  add_code('BD2R745', '3+', 100, task)
  add_code('BD3R4142', '1+', 100, task)
  add_code('BD4R1331', '1+', 100, task)
  add_code('BD5R5', '3+', 100, task)
  add_code('BD6R8428', '1', 100, task)
  add_code('BD7R4', '1', 100, task)
  add_code('BD8R8844', '1', 100, task)

  zone.reload


  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 400
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: '<img src=\'http://klads.org.ua/classic/129/files/nachalnik.png\'><br><br>
<b>Формат ответа:</b> одно слово кириллицей (все прочие знаки выбрасывайте)',
                     zone: zone)
  add_code('Рглор', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'Вам нужно название фигуры, имена, понятие, объединяющее логотипы')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 400
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: '<img src=\'http://klads.org.ua/classic/129/files/LannisterMormontStarkTargarien.png\'><br><br>
Назовите фрукт, который скрывается под знаком вопроса.<br><br>
<b>Формат ответа:</b> кириллица, одно слово
',
                     zone: zone)

  code_number = task.new_code_number
  code = Code.create(number: code_number, name: '', bonus: bonus, ko: 'null', color: 'red', task_id: task.id)
  CodeString.create(data: 'питайя', code: code)
  CodeString.create(data: 'питахайя', code: code)
  task.reload

  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'Обратите внимание на название файла и гербы')
  zone.reload



  # Kubraya
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number} - Кубраи",
                     data: "перед поля<br>
наказание odin<br>
жане певца<br>
из счастье<br>
еинелвиторпос вильнюс<br>
зимо чит<br><br>
Перед каждым ответом вводите #{zone.id}#{task_number}, например - <b>#{zone.id}#{task_number}кубрай</b>",
                     zone: zone)

  add_code("#{zone.id}#{task_number}засада", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}караван", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}алебарда", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}победа", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}молитва", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}летопись", 'null', bonus, task)

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


