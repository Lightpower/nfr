# encoding: UTF-8
CODE_COLORS = %w{red blue yellow white grey lightblue magenta orange green #AA8833}

##
# 2 zones, 1 task with 10 codes and 2 hints in each zone
# 2 teams with user
#
def create_simple_game
  game = FactoryGirl.create(:game)
  @teams = [Team.create(name: 'Boltons', alternative_name: 'DRузья',    image_url: '/images/test.png'),
            Team.create(name: 'Trants',  alternative_name: 'DRakoshki', image_url: '/images/test2.png') ]
  User.create(email: 'bol@ex.ua', password: '123456', password_confirmation: '123456', team: @teams.first)
  User.create(email: 'tra@ex.ua', password: '123456', password_confirmation: '123456', team: @teams.last)
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
