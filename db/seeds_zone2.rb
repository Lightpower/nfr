# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PRICE = {"1" => 400, "1+" => 59, "2" => 275, "2+" => 200, "3" => 350, "3+" => 400}



def create_zone2
  access_code = Code.create(number: 1, name: '', info: '', ko: 'null')
  CodeString.create(data: 'DoRn1234', code_id: access_code.id)
  zone = Zone.create(number: 2, name: 'Дорн', image_url: '', access_code: access_code)


  # 1 real task without access code for each zone
  task_number = zone.new_task_number
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Пуща-Водица <br>50.551624 30.341626',
                     zone: zone)

  add_code('BD1R41', '1+', 100, task)
  add_code('BD2R3219', '2', 100, task)
  add_code('BD3R2171', '2+', 100, task)
  add_code('BD4R', '1+', 100, task)
  add_code('BD5R448', '1', 100, task)
  add_code('BD6R3158', '1+', 100, task)
  add_code('BD7R717', '1+', 100, task)
  add_code('BD8R12', '2+', 100, task)
  add_code('BD9R9333', '1+', 100, task)
  add_code('BR1D11111', '1+', 100, task)
  add_code('BD11R4', '1+', 100, task)
  add_code('BD12R273', '1+', 100, task)
  add_code('BD13R892', '1+', 100, task)
  add_code('BD14R1', '1+', 100, task)
  add_code('BD15R9922', '1', 100, task)
  add_code('BD16R2429', '1+', 100, task)
  add_code('BD17R143', '1+', 100, task)
  add_code('BD18R78', '1+', 100, task)
  add_code('BD19R119', '1+', 100, task)
  add_code('BR2D8', '1+', 100, task)
  add_code('BD21R7', '1+', 100, task)
  add_code('BD22R38', '2', 100, task)
  add_code('BD23R6511', '1+', 100, task)
  add_code('BD24R42', '1+', 100, task)
  add_code('BD25R773', '1+', 100, task)
  add_code('BD26R7213', '1+', 100, task)
  add_code('BD27R7', '2+', 100, task)
  add_code('BD28R77', '1+', 100, task)
  add_code('BD29R9929', '1+', 100, task)
  add_code('BR3D', '1', 100, task)
  add_code('BD31R1313', '2+', 100, task)
  add_code('BD32R23', '3', 100, task)
  add_code('BD33R5353', '3+', 100, task)

  zone.reload

  # Closed task
  task_number = zone.new_task_number

  access_code = Code.create(number: 1, name: '', ko: ' null', bonus: -500)
  CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code)

  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Плиты на Академгородке<br>
<a href=\'http://wikimapia.org/#lang=ru&lat=50.464716&lon=30.343675&z=18&m=b\'>50.464716 30.343675<\a><br>
Ориентир: голубятня напротив Уборевича, 19. Правей метров 30.',
                     zone: zone,
                     access_code: access_code)

  add_code('BD1R134', '1+', 100, task)
  add_code('BD2R414', '1+', 100, task)
  add_code('BD3R2721', '1+', 100, task)
  add_code('BD4R7243', '1+', 100, task)
  add_code('BD5R1178', '1+', 100, task)
  add_code('BD6R1272', '1+', 100, task)
  add_code('BD7R8324', '1+', 100, task)

  zone.reload

  ###########################################################3
  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 360
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: '<img src=\'http://fs180.www.ex.ua/show/49727599/49727599.jpg\'><br><br>
Формат каждого ответа: латиница, более одного слова через пробел',
                     zone: zone)
  answer = ['Summer', 'Bran Stark', 'Shaggydog', 'Rickon Stark', 'Drogon', 'Drogo', 'Rhaegal', 'Rhaegar Ghost', 'Jon Snow', 'Grey Wind', 'Robb Stark', 'Lady', 'Sansa Stark', 'Nymeria', 'Arya Stark', 'Targaryen', 'Viserion', 'Viserys Targaryen']

  answer.each do |new_code|
    add_code(new_code, 'null', bonus / answer.size, task)
  end
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: '<img src=\'http://fs180.www.ex.ua/show/49727601/49727601.jpg\'>')
  Hint.create(task: task, number: 2, cost: -bonus*0.3, data: '<img src=\'http://fs211.www.ex.ua/show/50593904/50593904.jpg\'>')
  zone.reload

  # VIRTUAL
  task_number = zone.new_task_number
  bonus = 440
  task = Task.create(number: task_number, name: "Задание №#{task_number}",
                     data: 'Написанное во времена новых римлян легче прочитать верхом на слоне.<br><br>

<p style="font-family: \'Times New Roman\', serif;">Бриенна Тарт - силой и мужеством не уступает мужчинам. Являлась телохранителем Ренли I. Единcтвенный человек, любивший его искренне.<br>
Эммон Кью - утверждал, что убийцей Ренли является Бриенна Taрт. Hе смог противостоять Лорасу Тиреллу, был убит им же.<br>
Робар Ройс - прекрасный боец, с такими способностями мог бы служить при дворе Эйгона III и заполyчить немало побед.<br>
Гайард Морриген - известный рыцарь. Hевероятно тщеславный человек, при этом не обладающий особыми талантами.<br>
Пaрмен Крэйн - знаменитый рыцарь, переметнулся к Станнису после смерти Ренли. Взят в плен под Горьким Мостом.<br>
Брайс Карон - молодой, но известный рыцарь. Tак же, как и многие другие перешел на cторону Станниса, после смерти Ренли.</p>

<b>Формат ответа:</b> одно слово, кириллица',
                     zone: zone)

  add_code('Пестряк', 'null', bonus, task)
  Hint.create(task: task, number: 1, cost: -bonus*0.3, data: 'Ключ к решению в том, чем это задание визуально отличается от остальных.')
  Hint.create(task: task, number: 2, cost: -bonus*0.3, data: 'Сменив шрифт задания с (какого?) на (какой?), как это предлагает сделать первое предложение задания, и выстроив (каких?) гвардейцев по порядку, начиная с Робара Ройса, мы увидим два слова.')
  zone.reload



  # Kubraya
  task_number = zone.new_task_number
  bonus = 200
  task = Task.create(number: task_number, name: "Задание №#{task_number} - Кубраи",
                     data: "за мачта<br>
краб мордо<br>
дональд помощь<br>
низок веткер<br>
пни толко<br><br>
кипяток пластинк<br>
Перед каждым ответом вводите #{zone.id}#{task_number}, например - <b>#{zone.id}#{task_number}кубрай</b>",
                     zone: zone)

  add_code("#{zone.id}#{task_number}дорея", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}ракхаро", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}даксос", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}маллистер", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}бейлиш", 'null', bonus, task)
  add_code("#{zone.id}#{task_number}вардис", 'null', 190, task)

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


