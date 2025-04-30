# db/seeds.rb
# Create admin user
admin = User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

# Create regular user
user = User.create!(
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password'
)

# Create some expenses
5.times do |i|
  admin.expenses.create!(
    name: "Admin Expense #{i + 1}",
    amount: rand(10..100),
    date: Date.today - i.days
  )
  
  user.expenses.create!(
    name: "User Expense #{i + 1}",
    amount: rand(10..100),
    date: Date.today - i.days
  )
end