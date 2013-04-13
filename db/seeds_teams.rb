# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def destroy_world
  Team.destroy_all
  User.destroy_all
  Zone.destroy_all
  Task.destroy_all
  Hint.destroy_all
  Code.destroy_all
  CodeString.destroy_all
  TeamZone.destroy_all
  TeamCode.destroy_all
  Log.destroy_all
  TeamBonus.destroy_all
  TeamHint.destroy_all
  ZoneHolder.destroy_all
  TeamBonusAction.destroy_all
end

def create_teams

  team1 = Team.create(name: 'Старки', alternative_name: 'StrookS', image_url: '')
  User.create(email: 'strooks@ex.ua', password: '123456', password_confirmation: '123456', team: team1)

  team2 = Team.create(name: 'Таргариены', alternative_name: 'Vice Versa', image_url: '')
  User.create(email: 'viceversa@ex.ua', password: '123456', password_confirmation: '123456', team: team2)

  team3 = Team.create(name: 'Мартеллы', alternative_name: 'Гарем', image_url: '')
  User.create(email: 'garem@ex.ua', password: '123456', password_confirmation: '123456', team: team3)

  team4 = Team.create(name: 'Баратеоны', alternative_name: 'СТЫД', image_url: '')
  User.create(email: 'styd@ex.ua', password: '123456', password_confirmation: '123456', team: team4)

  team5 = Team.create(name: 'Ланнистеры', alternative_name: 'DeRzzzкий сад', image_url: '')
  User.create(email: 'sad@ex.ua', password: '123456', password_confirmation: '123456', team: team5)

  team6 = Team.create(name: 'Грейджои', alternative_name: 'КтоZDесь?', image_url: '')
  User.create(email: 'ktozdes@ex.ua', password: '123456', password_confirmation: '123456', team: team6)

  team7 = Team.create(name: 'Талли', alternative_name: 'Admin', image_url: '')
  User.create(email: 'a@ex.ua', password: '123123', password_confirmation: '123123', team: team7)

  # bonuses
  # create free codes
  task = Task.create(number: 1, name: "Стартовые резервы", data: '')
  code_names = %w(free1 free2free reserve_3 code4free free5_code res6free 7free7 free8_reserv res9code__ free10__ _11_free 12_in_reserve free__13_code f14_free fri_dr15 fdr16_ free_rd17 reserve_free_18 rezerve_19 freefree_20)



  # 20 codes for this task
  20.times do |i|
    code_number = task.new_code_number
    code = Code.create(task_id: task.id, number: code_number, name: '', bonus: 100, ko: " Null", color: 'black')
    CodeString.create(data: code_names[i], code: code)
  end
  task.save
  task.reload
  free_codes = task.codes

  #############################################################
  #Starks
  team = team1

  multiplier = 1.5
  ko = "null"
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "KoMultiplier",
      name: "Помощь старых богов",
      description: "Цена каждого кода с КО #{ko} умножается на #{multiplier}",
      ko: ko,
      rate: multiplier  # each Code with this ko will be multipled
  )
  multiplier = 1.1
  ko = "2"
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "KoMultiplier",
      name: "Лютоволк",
      description: "Цена каждого кода с КО #{ko} умножается на #{multiplier}",
      ko: ko,
      rate: multiplier  # each Code with this ko will be multipled
  )

  #Targariens
  team = team2
  drago_rate = 20
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "Warrior",
      name: "Удар дракона",
      description: "Возможность совершить захват раз в #{drago_rate} минут. Захват - это получение кода от доступного задания. Попытка всегда будет успешна.",
      rate: drago_rate,  # time of ability recharging
      amount: 1  # Number of code which can be stolen
  )

  #Martells
  team = team3
  multiplier = 1.3
  ko = "2"
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "KoMultiplier",
      name: "Несгибаемые (2)",
      description: "Цена каждого кода с КО #{ko} умножается на #{multiplier}",
      ko: ko,
      rate: multiplier  # each Code with this ko will be multipled
  )
  team = team3
  multiplier = 1.3
  ko = "2+"
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "KoMultiplier",
      name: "Несгибаемые (2+)",
      description: "Цена каждого кода с КО #{ko} умножается на #{multiplier}",
      ko: ko,
      rate: multiplier  # each Code with this ko will be multipled
  )
  pirate_rate = 40
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "Pirate",
      name: "Песчаные змейки",
      description: "Возможность совершить набег раз в #{pirate_rate} минут. Набег - это попытка получить код от доступного задания. Если код уже снимала другая команда, то попытка удачна, иначе - нет.",
      rate: pirate_rate,  # time of ability recharging
      amount: 1  # Number of code which can be stolen
  )

  # Baratheons
  team = team4
  multiplier = 2.1
  ko = "3"
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "KoMultiplier",
      name: "Высшая ярость  (3)",
      description: "Цена каждого кода с КО #{ko} умножается на #{multiplier}",
      ko: ko,
      rate: multiplier  # each Code with this ko will be multipled
  )
  multiplier = 2.1
  ko = "3+"
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "KoMultiplier",
      name: "Высшая ярость  (3+)",
      description: "Цена каждого кода с КО #{ko} умножается на #{multiplier}",
      ko: ko,
      rate: multiplier  # each Code with this ko will be multipled
  )
  drago_rate = 100
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "Warrior",
      name: "Верность королю",
      description: "Возможность совершить захват раз в #{drago_rate} минут. Захват - это получение кода от доступного задания. Попытка всегда будет успешна.",
      rate: drago_rate,  # time of ability recharging
      amount: 1  # Number of code which can be stolen
  )

  # Lannisters
  team = team5
  multiplier = 1.2
  ko = "1"
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "KoMultiplier",
      name: "Вассалы (1)",
      description: "Цена каждого кода с КО #{ko} умножается на #{multiplier}",
      ko: ko,
      rate: multiplier  # each Code with this ko will be multipled
  )
  multiplier = 1.2
  ko = "1+"
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "KoMultiplier",
      name: "Вассалы (1+)",
      description: "Цена каждого кода с КО #{ko} умножается на #{multiplier}",
      ko: ko,
      rate: multiplier  # each Code with this ko will be multipled
  )
  pirate_rate = 60
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "Pirate",
      name: "Грегор Клиган",
      description: "Возможность совершить набег раз в #{pirate_rate} минут. Набег - это попытка получить код от доступного задания. Если код уже снимала другая команда, то попытка удачна, иначе - нет.",
      rate: pirate_rate,  # time of ability recharging
      amount: 1  # Number of code which can be stolen
  )
  drago_rate = 60
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "Warrior",
      name: "Подкуп",
      description: "Возможность совершить захват раз в #{drago_rate} минут. Захват - это получение кода от доступного задания. Попытка всегда будет успешна.",
      rate: drago_rate,  # time of ability recharging
      amount: 1  # Number of code which can be stolen
  )

  # Lannisters
  team = team6
  multiplier = 1.2
  ko = "2+"
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "KoMultiplier",
      name: "Капитаны",
      description: "Цена каждого кода с КО #{ko} умножается на #{multiplier}",
      ko: ko,
      rate: multiplier  # each Code with this ko will be multipled
  )
  pirate_rate = 15
  TeamBonus.create(
      team_id: team.id,
      bonus_type: "Pirate",
      name: "Пират",
      description: "Возможность совершить набег раз в #{pirate_rate} минут. Набег - это попытка получить код от доступного задания. Если код уже снимала другая команда, то попытка удачна, иначе - нет.",
      rate: pirate_rate,  # time of ability recharging
      amount: 1  # Number of code which can be stolen
  )

end