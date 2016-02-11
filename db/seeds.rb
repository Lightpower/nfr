# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require_relative('seeds/seed_new_game')
# make_seed

Format.delete_all
Project.delete_all
Team.delete_all
User.delete_all

cq = Project.create(name: 'Карквест', en_name: 'carquest', url: nil, image_url: 'projects/carquest.jpg', position: 3)
fq = Project.create(name: 'Пеший квест', en_name: 'footquest', url: nil, image_url: 'projects/footquest.jpg', position: 2)
vq = Project.create(name: 'Виртуальный квест', en_name: 'virtualquest', url: nil, image_url: 'projects/virtualquest.jpg', position: 1)
Project.create(name: 'Квест-комнаты', en_name: 'carquest', url: 'http://vzaperti.com.ua', image_url: 'projects/questrooms.jpg', position: 0)

f_cq = Format.create(name: 'Приключение', css_class: 'advanture', project: cq)
f_fq = Format.create(name: 'Прогулка',    css_class: 'walk',      project: fq)
f_vq = Format.create(name: 'Онлайн',      css_class: 'online',    project: vq)

 # => User(id: integer, username: string, role: string, avatar_url: string, account: float, level: integer, team_id: integer, created_at: datetime, updated_at: datetime, email: string, 
# encrypted_password: string, reset_password_token: string, reset_password_sent_at: datetime, remember_created_at: datetime, sign_in_count: integer, current_sign_in_at: datetime, 
# last_sign_in_at: datetime, current_sign_in_ip: string, last_sign_in_ip: string) 

admin = User.create(username: 'admin', role: 'admin', password: 'qweqweqwe', password_confirmation: 'qweqweqwe', email: 'bva@bva.ua')
moder = User.create(username: 'moder', role: 'moderator', password: 'qweqweqwe', password_confirmation: 'qweqweqwe', email: 'test@test.ua')
