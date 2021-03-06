require 'faker'

Faker::Config.locale = 'en-US'

5.times do
  Hospital.create!(
    name:           Faker::Company.name,
    phone:          Faker::PhoneNumber.phone_number
  )
end

hospitals = Hospital.all

25.times do
  User.create!(
    first_name:     Faker::Name.first_name,
    last_name:      Faker::Name.last_name,
    role:           ['admin', 'nurse', 'doctor'].sample,
    email:          Faker::Internet.safe_email,
    password:       'helloworld',
    hospital:       hospitals.sample
  )
end

25.times do
  Patient.create!(
    first_name:     Faker::Name.first_name,
    last_name:      Faker::Name.last_name,
    hospital:       hospitals.sample,
    room_number:    (rand * 300 + 1).floor
  )
end

if User.where("email = ?", 'user@example.com').blank?
  User.create!(
    first_name:     'Bruce',
    last_name:      'Wayne',
    role:           'admin',
    email:          'user@example.com',
    password:       'helloworld',
    hospital:       hospitals.sample
  )
end

users = User.all

puts "#{hospitals.count} hospitals created."
puts "#{users.count} users created."