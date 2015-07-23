# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Type.create(name: 'Normal', description: 'Normal class, normal price')
Price.create(cost: '60', type_id: Type.first.id)
Appointment.create(class_date: Time.now, type_id: Type.first.id)
AdminUser.create(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
)
About.create(
  content: 'Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit. Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit.'
)
Headline.create(
  main: 'Headline',
  content: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eos animi, nobis illo. Repellendus atque dolorem, officia recusandae autem, laudantium consectetur, neque!'
)
HeadlineTwo.create(
  main: 'Headline',
  content: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eos animi, nobis illo. Repellendus atque dolorem, officia recusandae autem, laudantium consectetur, neque!'
)
HeadlineThree.create(
  main: 'Headline',
  content: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eos animi, nobis illo. Repellendus atque dolorem, officia recusandae autem, laudantium consectetur, neque!'
)