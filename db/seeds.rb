# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Status.create(short_title: 'stuff_wait', title: 'Waiting for Staff Response')
Status.create(short_title: 'customer_wait', title: 'Waiting for Customer')
Status.create(short_title: 'on_hold', title: 'On Hold')
Status.create(short_title: 'cancelled', title: 'Cancelled')
Status.create(short_title: 'completed', title: 'Completed')