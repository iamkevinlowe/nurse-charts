# require 'faker'

user = User.create!(
  first_name: 'Bruce',
  last_name:  'Wayne',
  role:       'admin',
  email:      'user@example.com',
  password:   'helloworld'
)

puts "#{user.first_name} #{user.last_name} has been created."