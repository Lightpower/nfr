# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require_relative 'seeds_teams'
require_relative 'seeds_zone0'
require_relative 'seeds_zone1'
require_relative 'seeds_zone2'
require_relative 'seeds_zone3'
require_relative 'seeds_zone4'
#require_relative 'seeds_zone5'
#require_relative 'seeds_zone6'
#require_relative 'seeds_zone7'
#require_relative 'seeds_zone8'

destroy_world
games = create_teams

games.each do |game|
  create_zone0(game)
  create_zone1(game)
  create_zone2(game)
  create_zone3(game)
  create_zone4(game)
  #create_zone5(game)
  #create_zone6(game)
  #create_zone7(game)
  #create_zone8(game)
end
#create_zone3
#create_zone4
#create_zone5
#create_zone6
#create_zone7

#update_1
