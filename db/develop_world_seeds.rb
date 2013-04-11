# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CODE_COLORS = %w{red blue yellow white grey lightblue magenta orange green #AA8833}
KO_LIST = %w(1 1+ 2 2+ 3 3+)

def create_test_game
# Team and User
  puts " Team and User:"

  TeamHint.destroy_all
  TeamCode.destroy_all
  TeamZone.destroy_all
  Log.destroy_all

  Team.destroy_all
  User.destroy_all
  team = Team.create(name: 'Boltons', alternative_name: 'DRузья', image_url: '/images/test.png')
  user = User.create(email: 'test@ex.ua', password: '123456', password_confirmation: '123456', team: team)
  puts " - Team and User are created"

  # Zones with accepted codes
  Code.destroy_all
  CodeString.destroy_all
  Zone.destroy_all


  access_codes = [
      Code.create(number: 1, name: '', info: '<font color=\'white\'>Королевство <b>Winterfell</b> доступно</font>',
                  ko: 'null'),
      Code.create(number: 1, name: '', info: '<font color=\'white\'>Королевство <b>Casterly Rock</b> доступно</font>',
                  ko: 'null')
  ]

  CodeString.create(data: 'Z111', code: access_codes.first)
  CodeString.create(data: 'Z222', code: access_codes.last)

  zones = [
      Zone.create(number: 1, name: 'Winterfell', image_url: '/image/test1.png', access_code: access_codes.first),
      Zone.create(number: 2, name: 'Casterly Rock', image_url: '/image/test2.png', access_code: access_codes.last)
  ]
  puts " - Zones with their access codes are created"

  # Tasks with codes and included tasks
  puts " Tasks with codes and included tasks"
  Task.destroy_all

  puts " For each zone: ..."
  zones.each do |zone|

    # 3 virtual tasks for each zone
    puts " Zone #{zone.number} - 3 virtual tasks"
    3.times.each do
      task_number = zone.new_task_number
      puts " -- Task #{task_number}"
      task = Task.create(number: task_number, name: "Задание №#{task_number}", code_quota: nil,
        data: '<b>Виртуальное задание.</b> Коды задания: <font color=\'orange\'>D номер зоны R + (номер задания*10 + номер кода)</font>',
        duration: nil, zone: zone)
      # 3 codes for each task
      puts "    ... with 3 virtual codes"
      3.times do
        code_number = task.new_code_number
        code = Code.create(number: code_number,
           name: '',
           bonus: 1,
           ko: 'null',
           info: '<b>Virtual</b> code',
           color: CODE_COLORS[code_number - 1])
        CodeString.create(data: "D#{zone.number}R#{ + task_number*10 + code_number}", code: code)
        task.codes << code
        task.reload

      end
      # 1 hint for each task
      puts "    ... with 3 hint"

      Hint.create(task: task, number: 1, cost: -1, data: '<i>Читайте задание внимательнее!</i>')
      Hint.create(task: task, number: 2, cost: -1, data: '<i>Как найти коды, выделено оранжевым.</i>')
      Hint.create(task: task, number: 3, cost: -2, data: '<i>Я не знаю, чем я ещё могу вам помочь.</i>')

      zone.reload
    end

    task_number = zone.new_task_number
    # 1 real task without access code for each zone
    puts " - 1 real task without access code"
    task = Task.create(number: task_number, name: "Задание №#{task_number}", code_quota: nil,
                       data: '<b>Типа реальные коды.</b> Коды задания: <font color=\'orange\'>R номер зоны D + (номер задания*10 + номер кода)</font><br>Первые пять кодов нанесены красным маркером, потом пять синим, потом пять жёлтым, оставшиеся - белым.',
                       duration: nil, zone: zone)
    # 10 codes for this task
    10.times do |i|
      code_number = task.new_code_number
      code = Code.create(
          number: code_number,
          name: '',
          bonus: i % 2 + 1,
          ko: "#{KO_LIST[i % 6]}",
          info: '<b>Код нанесён</b> на столбе',
          color: CODE_COLORS[i / 5])
      CodeString.create(data: "R#{zone.number}D#{ + task_number*10 + code_number}", code: code)
      task.codes << code
      task.reload
    end
    zone.reload

    # 1 real task with access code for each zone
    puts " - 1 real task with access code"
    task_number = zone.new_task_number

    access_code = Code.create(
        number: 1, name: '', info: "Задание №#{task_number} в зоне #{zone.number} доступно",
        ko: 'null', bonus: -5)
    CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code)

    task = Task.create(number: task_number, name: "Задание №#{task_number}", code_quota: nil,
                       preview: "Для получения задания введите код <b>T#{zone.number}T#{task_number}</b>",
                       data: '<b>Типа реальные коды.</b> Коды задания: <font color=\'orange\'>R номер зоны D + (номер задания*10 + номер кода)</font><br>Все коды чёрным маркером.',
                       duration: nil, zone: zone, access_code: access_code)
    # 10 codes for this task
    10.times do |i|
      code_number = task.new_code_number
      code = Code.create(
          number: code_number,
          name: '',
          bonus: i % 2 + 1,
          ko: "#{KO_LIST[i % 6]}" ,
          info: 'Код нанесён на лавочке',
          color: 'black')
      CodeString.create(data: "R#{zone.number}D#{ + task_number*10 + code_number}", code: code)
      task.codes << code
      task.reload
    end
    zone.reload

  end

  # Free task
  task = Task.create(number: 1, name: "За Узким морем", data: '')

  # 10 codes for this task
  10.times do
    code_number = task.new_code_number
    code = Code.create(
        number: code_number,
        name: '',
        bonus: code_number % 2 + 1,
        ko: "1+" ,
        info: 'Код нанесён на стене',
        color: 'red')
    CodeString.create(data: "R0D#{code_number}", code: code)
    task.codes << code
    task.reload
  end


  # Show the world
  puts "User: #{user.email}"
  puts "Team: #{team.name}"
  Zone.all.each do |zone|
    puts "### Zone #{zone.number} - #{zone.name} (access code: #{zone.access_code.code_strings.map(&:data).join(" ")})"
    zone.tasks.each do |tsk|
      access_code = tsk.access_code.present? ? tsk.access_code.code_strings.map(&:data).join(" ") : ""
      puts "\n  Task #{tsk.number} - access code #{access_code}"
      tsk.hints.each do |hint|
        puts "    Hint #{hint.number} (#{hint.cost} codes cost): #{hint.data}"
      end
      puts ""
      tsk.codes.each do |code|
        puts "    Code #{code.number}: #{code.code_strings.map(&:data).join(" ")}"
      end
    end


  end

  Task.where(zone_id: nil).each do |tsk|
    puts "\n  Free Task #{tsk.number}"
    tsk.codes.each do |code|
      puts "    Code #{code.number}: #{code.code_strings.map(&:data).join(" ")}"
    end
  end


  # Bonuses for each Team
  Team.all.each do |t|
    TeamBonus.destroy_all

    multiplier = 1.1 + rand(9) / 10
    ko = (KO_LIST + %w(null))[rand(7)]
    TeamBonus.create(
        team_id: t.id,
        bonus_type: "KoMultiplier",
        name: "Сила мозга",
        description: "Цена каждого кода с КО #{ko} умножается на #{multiplier}",
        ko: ko,
        rate: multiplier  # each Code with this ko will be multipled
    )
    pirate_rate = 5 + rand(10)
    TeamBonus.create(
        team_id: t.id,
        bonus_type: "Pirate",
        name: "Гоп-стоп",
        description: "Возможность совершить набег раз в #{pirate_rate} минут. Набег - это попытка получить код от доступного задания. Если код уже снимала другая команда, то попытка удачна, иначе - нет.",
        rate: pirate_rate,  # time of ability recharging
        amount: 1  # Number of code which can be stealed
    )
    drago_rate = 5 + rand(10)
    TeamBonus.create(
        team_id: t.id,
        bonus_type: "Warrior",
        name: "Конкретный наезд",
        description: "Возможность совершить захват раз в #{drago_rate} минут. Захват - это получение кода от доступного задания. Попытка всегда будет успешна.",
        rate: drago_rate,  # time of ability recharging
        amount: 1  # Number of code which can be stealed
    )
  end
end

def create_public_game
# Team and User
  puts " Team and User:"

  TeamHint.destroy_all
  TeamCode.destroy_all
  TeamZone.destroy_all
  Log.destroy_all

  Team.destroy_all
  User.destroy_all

  houses = %w(Bolton Jast Dayne Dondarrion Frey Goodbrother Corbray Pain Amber Drogo)

  # Zones with accepted codes
  Code.destroy_all
  CodeString.destroy_all
  Zone.destroy_all

  kingdoms = ["Север", "Замковый Утёс", "Дорн", "Штормовые земли", "Речные земли", "Соль и Камень", "Долина Аррен"]

  20.times { |i|
    h_name = i<10 ? houses[i] : "House#{i}"
    if Team.find_by_name(h_name).blank?
      team = Team.create(name: h_name, image_url: "/images/house_test#{i}.png")
      User.create(email: "test#{i}@ex.ua", password: '123456', password_confirmation: '123456', team: team)
    end
  }
  7.times { |i|
    code = Code.create(number: i+1, name: '', ko: 'null')
    CodeString.create(data: "Z#{(i+1).to_s * 3}", code: code)
    Zone.create(number: i+1, name: kingdoms[i], image_url: "/image/test#{i+1}.png", access_code: code)
  }
  puts " - Team, User and Zones with their access codes are created"

  # Tasks with codes and included tasks
  puts " Tasks with codes and included tasks"
  Task.destroy_all

  puts " For each zone: ..."
  Zone.all.each do |zone|

    # 10 virtual tasks for each zone
    puts " Zone #{zone.number} - 3 virtual tasks"
    10.times.each do
      task_number = zone.new_task_number
      puts " -- Task #{task_number}"
      task = Task.create(number: task_number, name: "Задание №#{task_number}", code_quota: nil,
                         data: '<b>Виртуальное задание.</b> Коды задания: <font color=\'orange\'>D номер зоны R + (номер задания*10 + номер кода)</font>',
                         duration: nil, zone: zone)
      # 2 codes for each task
      puts "    ... with 2 virtual codes"
      2.times do |i|
        code_number = task.new_code_number
        code = Code.create(number: code_number,
                           name: '',
                           bonus: i + 1,
                           ko: 'null',
                           info: '<b>Virtual</b> code',
                           color: 'black')
        CodeString.create(data: "D#{zone.number}R#{ + task_number*10 + code_number}", code: code)
        task.codes << code
        task.reload

      end
      # 3 hint for each task
      puts "    ... with 3 hint"

      Hint.create(task: task, number: 1, cost: -0.5, data: '<i>Читайте задание внимательнее!</i>')
      Hint.create(task: task, number: 2, cost: -0.5, data: '<i>Как найти коды, выделено оранжевым.</i>')
      Hint.create(task: task, number: 3, cost: -1, data: '<i>Я не знаю, чем я ещё могу вам помочь.</i>')

      zone.reload
    end

    task_number = zone.new_task_number
    # 1 real task without access code for each zone
    puts " - 1 real task without access code"
    task = Task.create(number: task_number, name: "Задание №#{task_number}", code_quota: nil,
                       data: '<b>Типа реальные коды.</b> Коды задания: <font color=\'orange\'>R номер зоны D + (номер задания*10 + номер кода)</font><br>Первые пять кодов нанесены красным маркером, потом пять синим, потом пять жёлтым, оставшиеся - белым.',
                       duration: nil, zone: zone)
    # 10 codes for this task
    10.times do |i|
      code_number = task.new_code_number
      code = Code.create(
          number: code_number,
          name: '',
          bonus: i % 2 + 1,
          ko: "#{KO_LIST[i % 6]}",
          info: '<b>Код нанесён</b> на столбе',
          color: CODE_COLORS[i / 5])
      CodeString.create(data: "R#{zone.number}D#{ + task_number*10 + code_number}", code: code)
      task.codes << code
      task.reload
    end
    zone.reload

    # 1 real task with access code for each zone
    puts " - 1 real task with access code"
    task_number = zone.new_task_number

    access_code = Code.create(
        number: 1, name: '', info: "Задание №#{task_number} в зоне #{zone.number} доступно",
        ko: 'null', bonus: -5)
    CodeString.create(data: "T#{zone.number}T#{task_number}", code: access_code)

    task = Task.create(number: task_number, name: "Задание №#{task_number}", code_quota: nil,
                       preview: "Для получения задания введите код <b>T#{zone.number}T#{task_number}</b>",
                       data: '<b>Типа реальные коды.</b> Коды задания: <font color=\'orange\'>R номер зоны D + (номер задания*10 + номер кода)</font><br>Все коды чёрным маркером.',
                       duration: nil, zone: zone, access_code: access_code)
    # 10 codes for this task
    10.times do |i|
      code_number = task.new_code_number
      code = Code.create(
          number: code_number,
          name: '',
          bonus: i % 2 + 1,
          ko: "#{KO_LIST[i % 6]}" ,
          info: 'Код нанесён на лавочке',
          color: 'black')
      CodeString.create(data: "R#{zone.number}D#{ + task_number*10 + code_number}", code: code)
      task.codes << code
      task.reload
    end
    zone.reload

  end

  # Free task
  task = Task.create(number: 1, name: "За Узким морем", data: '')

  # 10 codes for this task
  10.times do
    code_number = task.new_code_number
    code = Code.create(
        number: code_number,
        name: '',
        bonus: code_number % 2 + 1,
        ko: "1+" ,
        info: 'Код нанесён на стене',
        color: 'red')
    CodeString.create(data: "R0D#{code_number}", code: code)
    task.codes << code
    task.reload
  end


  # Show the world
  puts "Users: #{User.all.map(&:email).join(', ')}"
  puts "Teams: #{Team.all.map(&:name).join(', ')}"
  #Zone.all.each do |zone|
  #  puts "### Zone #{zone.number} - #{zone.name} (access code: #{zone.access_code.code_strings.map(&:data).join(" ")})"
  #  zone.tasks.each do |tsk|
  #    access_code = tsk.access_code.present? ? tsk.access_code.code_strings.map(&:data).join(" ") : ""
  #    puts "\n  Task #{tsk.number} - access code #{access_code}"
  #    tsk.hints.each do |hint|
  #      puts "    Hint #{hint.number} (#{hint.cost} codes cost): #{hint.data}"
  #    end
  #    puts ""
  #    tsk.codes.each do |code|
  #      puts "    Code #{code.number}: #{code.code_strings.map(&:data).join(" ")}"
  #    end
  #  end
  #
  #
  #end
  #
  #Task.where(zone_id: nil).each do |tsk|
  #  puts "\n  Free Task #{tsk.number}"
  #  tsk.codes.each do |code|
  #    puts "    Code #{code.number}: #{code.code_strings.map(&:data).join(" ")}"
  #  end
  #end


  # Bonuses for each Team
  Team.all.each do |t|
    TeamBonus.destroy_all

    multiplier = 1.1 + rand(9) / 10
    ko = (KO_LIST + %w(null))[rand(7)]
    TeamBonus.create(
        team_id: t.id,
        bonus_type: "KoMultiplier",
        name: "Сила мозга",
        description: "Цена каждого кода с КО #{ko} умножается на #{multiplier}",
        ko: ko,
        rate: multiplier  # each Code with this ko will be multipled
    )
    pirate_rate = 5 + rand(10)
    TeamBonus.create(
        team_id: t.id,
        bonus_type: "Pirate",
        name: "Гоп-стоп",
        description: "Возможность совершить набег раз в #{pirate_rate} минут. Набег - это попытка получить код от доступного задания. Если код уже снимала другая команда, то попытка удачна, иначе - нет.",
        rate: pirate_rate,  # time of ability recharging
        amount: 1  # Number of code which can be stealed
    )
    drago_rate = 5 + rand(10)
    TeamBonus.create(
        team_id: t.id,
        bonus_type: "Warrior",
        name: "Конкретный наезд",
        description: "Возможность совершить захват раз в #{drago_rate} минут. Захват - это получение кода от доступного задания. Попытка всегда будет успешна.",
        rate: drago_rate,  # time of ability recharging
        amount: 1  # Number of code which can be stealed
    )
  end
end

def add_team_to_20
  houses = %w(Bolton Jast Dayne Dondarrion Frey Goodbrother Corbray Pain Amber Drogo)
  20.times { |i|
    h_name = i<10 ? houses[i] : "House#{i}"
    if Team.find_by_name(h_name).blank?
      team = Team.create(name: h_name, image_url: "/images/house_test#{i}.png")
      User.create(email: "test#{i}@ex.ua", password: '123456', password_confirmation: '123456', team: team)
    end
  }

  puts "Users: #{User.all.map(&:email).join(', ')}"
  puts "Teams: #{Team.all.map(&:name).join(', ')}"

end