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


  # create free codes
  task = Task.where(zone_id: nil).first
  code_names = %w(zd1r724 zd2r817 zd3r333 zd4r87 zd5r72 zd6r34 zd7r432 zd8r21 zd9r zd10r270387 zd11r8121983 zd12r121488 zd13r817 zd14r131 zd15r7)

  # 20 codes for this task
  15.times do |i|
    code_number = task.new_code_number
    code = Code.create(task_id: task.id, number: code_number, name: '', bonus: 100, ko: "bonus", color: 'black')
    CodeString.create(data: code_names[i], code: code)
  end
  task.save
  task.reload

end