# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Profile.destroy_all
TodoList.destroy_all
TodoItem.destroy_all

User.create! [
    { username: "Fiorina", password_digest: "123" },
    { username: "Trump", password_digest: "bah" },
    { username: "Carson", password_digest: "meh" },
    { username: "Clinton", password_digest: "jau" }
    
]

User.find_by!(username: "Fiorina").create_profile(gender: "female", birth_year: 1954, first_name: "Carly", last_name: "Fiorina")
User.find_by!(username: "Trump").create_profile(gender: "male", birth_year: 1946, first_name: "Donald", last_name: "Trump")
User.find_by!(username: "Carson").create_profile(gender: "male", birth_year: 1951, first_name: "Ben", last_name: "Carson")
User.find_by!(username: "Clinton").create_profile(gender: "female", birth_year: 1947, first_name: "Hillary", last_name: "Clinton")

User.all.each do |u|
     u.todo_lists << TodoList.create(list_name: (u.username + " todos"), list_due_date: (Date.today + 1.year))
end

TodoList.all.each do |list|
    for i in 0..4 
        list.todo_items << TodoItem.create(due_date: (Date.today + 1.year), title: (i.to_s + list.list_name + "tjohei")) 
    end
end