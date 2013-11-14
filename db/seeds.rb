# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
User.create!(name:'admin',
	email: 'admin@example.com',
	user_name: 'adminner',	
	password: 'test88',
	password_confirmation: 'test88',
	admin: true)
User.create!(name:'Tom',
	email: 'tom@gmail.com',
	user_name: 'TMan',	
	password: 'test88',
	password_confirmation: 'test88',
	admin: false)
User.create!(name:'Kathryn',
	email: 'k@gmail.com',
	user_name: 'sweet heart',	
	password: 'test88',
	password_confirmation: 'test88',
	admin: false)
User.create!(name:'Alan',
	email: 'alan@gmail.com',
	user_name: 'pop',	
	password: 'test88',
	password_confirmation: 'test88',
	admin: false)