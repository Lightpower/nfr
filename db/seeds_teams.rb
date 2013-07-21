# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def destroy_world
  Game.where('id > 1').destroy_all
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
  games = create_games
  game_v = games.first
  game_1 = games.last

  user = User.create(username: 'mega-kiev_Sinenkiy',email: 'a1@a.a', password: '132632', password_confirmation: '132632')
  team = Team.create(name: 'DaIGR (Москва)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_v.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_Briz',email: 'a2@a.a', password: '742995', password_confirmation: '742995')
  team = Team.create(name: 'DozoRные Волки (Смоленск)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_v.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_KAA',email: 'a3@a.a', password: '844939', password_confirmation: '844939')
  team = Team.create(name: 'Tula in Team (Тула)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_v.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_satirsky',email: 'a4@a.a', password: '234561', password_confirmation: '234561')
  team = Team.create(name: 'White Eagles & Co (Москва)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_v.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_puh_puh',email: 'a5@a.a', password: '936765', password_confirmation: '936765')
  team = Team.create(name: 'Горький Город (Нижний Новгород)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_v.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_ONIks',email: 'a6@a.a', password: '163337', password_confirmation: '163337')
  team = Team.create(name: 'Жесть (Рязань)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_v.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_Magvai_Light',email: 'a7@a.a', password: '952494', password_confirmation: '952494')
  team = Team.create(name: 'Легендарный Севастополь', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_v.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_GnuZZZ',email: 'a8@a.a', password: '543283', password_confirmation: '543283')
  team = Team.create(name: 'НЕВАпрос! (Санкт-Петербург)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_v.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_xStalker',email: 'a9@a.a', password: '755421', password_confirmation: '755421')
  team = Team.create(name: 'ТК (Тверь)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_v.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_SEXXX',email: 'aa@a.a', password: '944653', password_confirmation: '944653')
  team = Team.create(name: 'ТТ - Тульский Токарев (Тула)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_v.id, team_id: team.id)

  user = User.create(username: 'tstv',email: 'ab@a.a', password: '123123', password_confirmation: '123123')
  team = Team.create(name: 'Test_V', image_url: '', user_id: user.id)
  user.role = 'admin'
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_v.id, team_id: team.id)



  user = User.create(username: 'mega-kiev_Romashechka',email: 'ac@a.a', password: '551887', password_confirmation: '551887')
  team = Team.create(name: '+500 (Архангельск)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_1.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_zzzvuk',email: 'ad@a.a', password: '287212', password_confirmation: '287212')
  team = Team.create(name: 'BezPredel (Псков)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_1.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_VADimxo',email: 'ae@a.a', password: '453368', password_confirmation: '453368')
  team = Team.create(name: 'DespeRados (Москва)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_1.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_REQ',email: 'af@a.a', password: '986827', password_confirmation: '986827')
  team = Team.create(name: 'In Team не предлагать (Тула)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_1.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_Oleg_Obninsk',email: 'ag@a.a', password: '355657', password_confirmation: '355657')
  team = Team.create(name: 'obninsk team (Обнинск)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_1.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_Pedr0',email: 'ah@a.a', password: '336146', password_confirmation: '336146')
  team = Team.create(name: 'SWEDEN KAPUT (Полтава)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_1.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_sevenThANK',email: 'ai@a.a', password: '662778', password_confirmation: '662778')
  team = Team.create(name: 'Зайчеги&Ко (Сборная Урала)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_1.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_unixway',email: 'aj@a.a', password: '244848', password_confirmation: '244848')
  team = Team.create(name: 'Кошмар и Odinteam (Одинцово)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_1.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_Korvyn',email: 'ak@a.a', password: '219747', password_confirmation: '219747')
  team = Team.create(name: 'Сборная Санкт-Петербурга', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_1.id, team_id: team.id)

  user = User.create(username: 'mega-kiev_Sobol86',email: 'al@a.a', password: '234826', password_confirmation: '234826')
  team = Team.create(name: 'Столица ЮГА (Ростов)', image_url: '', user_id: user.id)
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_1.id, team_id: team.id)

  user = User.create(username: 'tst1',email: 'am@a.a', password: '123123', password_confirmation: '123123')
  team = Team.create(name: 'Test_1', image_url: '', user_id: user.id)
  user.role = 'admin'
  user.team_id = team.id
  user.save
  GameRequest.create(is_accepted: true, game_id: game_1.id, team_id: team.id)

  games
end

def create_games
  [
      Game.create(number: '80', name: 'MDR - Ведьмак в Большом Киеве - ВЫСШАЯ ЛИГА', format: 'dozor_classic', game_type: 'zones', start_date: '2013-06-29 03:00:00',
        finish_date: '2013-06-30 10:00:00', image_html: '<img src="http://arzamas-16.org/files/anons01.jpg">', is_active: true,
        is_archived: false),
      Game.create(number: '81', name: 'MDR - Ведьмак в Большом Киеве - ПЕРВАЯ ЛИГА', format: 'dozor_classic', game_type: 'zones', start_date: '2013-06-29 03:00:00',
        finish_date: '2013-06-30 10:00:00', image_html: '<img src="http://arzamas-16.org/files/anons01.jpg">', is_active: true,
        is_archived: false)
  ]
end
