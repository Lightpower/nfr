# encoding: UTF-8
CODE_COLORS = %w{red blue yellow white grey lightblue magenta orange green #AA8833}

##
# 2 zones, 1 task with 10 codes and 2 hints in each zone
# 2 teams with user
#
def create_simple_game
  game = FactoryGirl.create(:game, game_type: 'conquest')
  FactoryGirl.create(:game_config, game: game)
  game.reload

  @users = [User.create(email: 'bol@ex.ua', password: '123456', password_confirmation: '123456'),
            User.create(email: 'tra@ex.ua', password: '123456', password_confirmation: '123456') ]
  @teams = [Team.create(name: 'Boltons', alternative_name: 'DRузья',    image_url: '/images/test.png', user_id: @users.first.id),
            Team.create(name: 'Trants',  alternative_name: 'DRakoshki', image_url: '/images/test2.png', user_id: @users.last.id) ]
  @users.first.team = @teams.first
  @users.first.save
  @users.last.team = @teams.last
  @users.last.save
  # Requests to game
  @teams.each { |team| FactoryGirl.create(:game_request, game: game, team: team, is_accepted: true) }

  # Zones with accepted codes
  access_codes = [
      Code.create(game: game, number: 1, name: '', info: '<font color=\'white\'>Королевство <b>Winterfell</b> доступно</font>',
                  ko: 'null'),
      Code.create(game: game, number: 1, name: '', info: '<font color=\'white\'>Королевство <b>Casterly Rock</b> доступно</font>',
                  ko: 'null')
  ]

  CodeString.create(game: game, data: 'Z111', code: access_codes.first)
  CodeString.create(game: game, data: 'Z222', code: access_codes.last)

  Zone.create(game: game, number: 1, name: 'Winterfell', image_url: '/image/test1.png', access_code: access_codes.first)
  Zone.create(game: game, number: 2, name: 'Casterly Rock', image_url: '/image/test2.png', access_code: access_codes.last)

  # Tasks with codes and included tasks

  Zone.all.each do |zone|

    # 1 virtual task for each zone
    task_number = zone.new_task_number
    task = Task.create(game: game, number: task_number, name: "Задание №#{task_number}", code_quota: nil,
                       data: '<b>Виртуальное задание.</b> Коды задания: <font color=\'orange\'>D номер зоны R + (номер задания*10 + номер кода)</font>',
                       duration: nil, zone: zone)
    # 3 codes for task
    3.times do
      code_number = task.new_code_number
      code = Code.create(game: game, number: code_number,
                         name: '',
                         bonus: 1,
                         ko: 'null',
                         info: '<b>Virtual</b> code',
                         color: CODE_COLORS[code_number - 1])
      CodeString.create(game: game, data: "D#{zone.number}R#{ + task_number*10 + code_number}", code: code)
      task.codes << code
      task.reload

    end

    task.save

    # 2 hints for each task
    Hint.create(game: game, task: task, number: 1, cost: -1, data: '<i>Читайте задание внимательнее!</i>')
    Hint.create(game: game, task: task, number: 2, cost: -1, data: '<i>Как найти коды, выделено оранжевым.</i>')


    # 1 real task with access code for each zone
    task_number = zone.new_task_number

    access_code = Code.create(
        game: game, number: 1, name: '', info: "Задание №#{task_number} в зоне #{zone.number} доступно",
        ko: 'null', bonus: -2)
    CodeString.create(game: game, data: "T#{zone.number}T#{task_number}", code: access_code)

    task = Task.create(game: game, number: task_number, name: "Задание №#{task_number}", code_quota: nil,
                       preview: "Для получения задания введите код <b>T#{zone.number}T#{task_number}</b>",
                       data: '<b>Типа реальные коды.</b> Коды задания: <font color=\'orange\'>R номер зоны D + (номер задания*10 + номер кода)</font>',
                       duration: nil, zone: zone, access_code: access_code)

    # 10 codes for this task
    10.times do
      code_number = task.new_code_number
      code = Code.create(
          game: game,
          number: code_number,
          name: '',
          bonus: code_number % 2 + 1,
          ko: "#{task_number % 6}" ,
          info: 'Код нанесён на лавочке',
          color: CODE_COLORS[code_number - 1])
      CodeString.create(game: game, data: "R#{zone.number}D#{ + task_number*10 + code_number}", code: code)
      task.codes << code
    end

    task.save

    # 2 hints for each task
    Hint.create(game: game, task: task, number: 1, cost: -1, data: '<i>Читайте задание внимательнее!</i>')
    Hint.create(game: game, task: task, number: 2, cost: -1, data: '<i>Как найти коды, выделено оранжевым.</i>')
  end

  game
end

##
# Destroy the environment which was created by create_simple_game method
#
def destroy_simple_game
  Zone.destroy_all
  ZoneHolder.destroy_all
  User.destroy_all
  Team.destroy_all
  Task.destroy_all
  Hint.destroy_all
  Code.destroy_all
  CodeString.destroy_all
  TeamCode.destroy_all
  TeamHint.destroy_all
  Log.destroy_all
  Game.destroy_all
end

##
# Emulate some game activity (passing the codes)
#
def emulate_game_activity(game=nil)
  game ||= Game.first
  teams = Team.all

  # access all teams to all zones
  teams.each do |team|
    Zone.all.map(&:access_code).each do |code|
      GameStrategy::Context.send_code({game: game, code_string: code.show_code, user: team.users.first})
    end
  end

  # pass all codes of task which doesn't have access code
  teams.each do |team|
    Zone.all.map(&:tasks).flatten.select {|task| task.access_code == nil}.map(&:codes).flatten do |code|
      GameStrategy::Context.send_code({game: game, code_string: code.show_code, user: team.users.first})
    end
  end
end

##
# 2 zones, 1 task with 10 codes and 2 hints in each zone
# 2 teams with user
#
def create_line_game
  game = FactoryGirl.create(:game, game_type: 'line')
  FactoryGirl.create(:game_config, game: game)
  game.reload

  @users = [User.create(email: 'u1@ex.ua', password: '123456', password_confirmation: '123456'),
            User.create(email: 'u2@ex.ua', password: '123456', password_confirmation: '123456') ]
  @teams = [Team.create(name: 'Team1', alternative_name: 'Team 1',    image_url: '/images/test.png', user_id: @users.first.id),
            Team.create(name: 'Team2',  alternative_name: 'Team 2', image_url: '/images/test2.png', user_id: @users.last.id) ]
  @users.first.team = @teams.first
  @users.first.save
  @users.last.team = @teams.last
  @users.last.save
  # Requests to game
  @teams.each { |team| FactoryGirl.create(:game_request, game: game, team: team, is_accepted: true) }

  Zone.create(game: game, number: 1, name: 'Winterfell', image_url: '/image/test1.png')
  Zone.create(game: game, number: 2, name: 'Casterly Rock', image_url: '/image/test2.png')

  # Tasks with codes and included tasks

  Zone.all.each do |zone|

    # task 1 - 1 code
    task_number = zone.new_task_number
    task = Task.create(game: game, number: task_number, name: "Задание №#{task_number}", code_quota: 0, # all codes
                       data: '<b>Четыре колобка свалились под мост.</b> Коды задания: <font color=\'orange\'>D номер зоны R + (номер задания*10 + номер кода)</font>',
                       duration: 60, zone: zone)
    # Code
    code_number = task.new_code_number
    code = Code.create(game: game, number: code_number,
                       name: '',
                       bonus: 0,
                       ko: '1+',
                       info: 'Под лавочкой',
                       color: 'red')
    CodeString.create(game: game, data: "D#{zone.number}R#{ + task_number*10 + code_number}", code: code)
    task.codes << code
    task.reload

    # 2 hints for each task
    Hint.create(game: game, task: task, number: 1, delay: 20, cost: -1, data: '<i>Читайте задание внимательнее!</i>')
    Hint.create(game: game, task: task, number: 2, delay: 40, cost: -1, data: '<i>Как найти коды, выделено оранжевым.</i>')


    # Task 2 - 10 codes
    task_number = zone.new_task_number
    task = Task.create(game: game, number: task_number, name: "Задание №#{task_number}", code_quota: -1, # all minus one
                       data: '<b>Большой поиск.</b> Коды задания: <font color=\'orange\'>D номер зоны R + (номер задания*10 + номер кода)</font>',
                       duration: 50, zone: zone)
    # Codes
    infos = %w(Первый Второй Третий Четвёртый Пятый Шестой Седьмой Восьмой Девятый Десятый)
    10.times do
      code_number = task.new_code_number
      code = Code.create(game: game, number: code_number,
                         name: '',
                         bonus: 0,
                         ko: '1+',
                         info: infos[code_number - 1],
                         color: 'blue')
      CodeString.create(game: game, data: "D#{zone.number}R#{ + task_number*10 + code_number}", code: code)
      task.codes << code
    end
    task.reload

    # 2 hints for each task
    Hint.create(game: game, task: task, number: 1, delay: 15, cost: -1, data: '<i>Коды можно подобрать.</i>')
    Hint.create(game: game, task: task, number: 2, delay: 30, cost: -1, data: '<i>Как вычислить коды, выделено оранжевым.</i>')

  end

  game
end
