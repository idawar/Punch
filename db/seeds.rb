# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..10).each do |index|
	role = index % 2
	User.create(role: role, name: "Tester#{index}", email: "emp.#{index}@punch.com")
end

(1..10).each do |index|
	role = index % 2
	Project.create(name: "Punch-#{index}", description: "")
end