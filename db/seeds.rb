# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Type.create(
  name: 'Normal',
  blurb: 'Bacon ipsum dolor sit amet',
  description: 'Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit. Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit.',
  cost: 70,
  image_url: 'http://i.imgur.com/5TmBuib.jpg'
)
Type.create(
  name: 'Advanced',
  blurb: 'Bacon ipsum dolor sit amet',
  description: 'Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit. Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit.',
  cost: 100,
  image_url: 'http://i.imgur.com/5TmBuib.jpg'
)
Appointment.create(
  class_date: Time.now,
  type_id: 1
)
Appointment.create(
  class_date: Time.now,
  type_id: 2
)
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
MainHeaderImage.create(image_url: 'http://i.imgur.com/5TmBuib.jpg')
Refund.create(policy: '')