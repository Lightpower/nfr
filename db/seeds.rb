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

cq = Project.create(name: 'Городские квесты', en_name: 'cityquest', url: nil, image_url: 'projects/cityquest.jpg', position: 0)

f_cq = Format.create(name: 'Conquest', css_class: 'conquest', project: cq)

 # => User(id: integer, username: string, role: string, avatar_url: string, account: float, level: integer, team_id: integer, created_at: datetime, updated_at: datetime, email: string, 
# encrypted_password: string, reset_password_token: string, reset_password_sent_at: datetime, remember_created_at: datetime, sign_in_count: integer, current_sign_in_at: datetime, 
# last_sign_in_at: datetime, current_sign_in_ip: string, last_sign_in_ip: string) 

admin = User.create(username: 'admin', role: 'admin', password: 'qweqweqwe', password_confirmation: 'qweqweqwe', email: 'admin@admin.ua')
