# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def update_1
  team1 = Team.find_by_name 'Старки'
  User.create(email: 'adm_strooks@ex.ua', password: '123456', password_confirmation: '123456', team: team1)

  team2 = Team.find_by_name 'Таргариены'
  User.create(email: 'adm_viceversa@ex.ua', password: '123456', password_confirmation: '123456', team: team2)

  team3 = Team.find_by_name 'Мартеллы'
  User.create(email: 'adm_garem@ex.ua', password: '123456', password_confirmation: '123456', team: team3)

  team4 = Team.find_by_name 'Баратеоны'
  User.create(email: 'adm_styd@ex.ua', password: '123456', password_confirmation: '123456', team: team4)

  team5 = Team.find_by_name 'Ланнистеры'
  User.create(email: 'adm_sad@ex.ua', password: '123456', password_confirmation: '123456', team: team5)

  team6 = Team.find_by_name 'Грейджои'
  User.create(email: 'adm_ktozdes@ex.ua', password: '123456', password_confirmation: '123456', team: team6)

end