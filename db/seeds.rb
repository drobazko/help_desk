def rand_record(table_name)
  table_name.find(table_name.ids[rand(1..table_name.count)-1])
end

departments_quantity = 5
tickets_quantity = 20
staffs_quantity = 5
posts_quantity = 10
customers_quantity = 5

Status.create(short_title: 'staff_wait', title: 'Waiting for Staff Response')
Status.create(short_title: 'customer_wait', title: 'Waiting for Customer')
Status.create(short_title: 'on_hold', title: 'On Hold')
Status.create(short_title: 'cancelled', title: 'Cancelled')
Status.create(short_title: 'completed', title: 'Completed')

1.upto(departments_quantity){|i| Department.create(title: "Sample Departament ##{i}")}

Ticket.create(
  customer_name: "Drobazko Alex", 
  customer_email: "drobazko2@gmail.com",
  subject: Faker::Lorem.sentence, 
  body: Faker::Lorem.paragraph,
  department: rand_record(Department)
)

1.upto(tickets_quantity){|i| 
  Ticket.create(
    customer_name: Faker::Name.name, 
    customer_email: Faker::Internet.email,
    subject: Faker::Lorem.sentence, 
    body: Faker::Lorem.paragraph,
    department: rand_record(Department)
  )
}

# One Admin
Staff.create!(
  name: 'Admin', 
  email: 'admin@helpdesk.com', 
  password: '12345678', 
  password_confirmation: '12345678', 
  role: 'admin'
)

1.upto(customers_quantity){|i| 
  staff = Staff.new(
    name: Faker::Name.name, 
    email: "customer_#{i}@helpdesk.com", 
    password: '12345678', 
    password_confirmation: '12345678',
    role: 'customer'
  )

  1.upto(posts_quantity){|j| staff.posts.new(
    body: "It's Simple Sample Customer ##{i} Post ##{j}. #{Faker::Lorem.paragraph} Enjoy It!",
    ticket: rand_record(Ticket)
    )
  }
  
  staff.save
}

# Staff Members
1.upto(staffs_quantity){|i| 
  staff = Staff.new(
    name: Faker::Name.name, 
    email: "member_#{i}@helpdesk.com", 
    password: '12345678', 
    password_confirmation: '12345678',
  )

  staff.department = rand_record(Department)

  1.upto(posts_quantity){|j| staff.posts.new(
    body: "It's Simple Sample Stuff ##{i} Post ##{j}. #{Faker::Lorem.paragraph} Enjoy It!",
    ticket: rand_record(Ticket)
    )
  }
  
  staff.save
}
