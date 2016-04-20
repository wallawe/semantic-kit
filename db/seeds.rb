User.delete_all
Category.delete_all
Theme.delete_all


#####################
### Create Users
#####################

will = User.create(email: "wallac.will@gmail.com", password: "password",
                   password_confirmation: "password", username: "wallawe",
                   location: "NYC",
                   website: "will-wallace.com", about: "Awesome")

travis = User.create(email: "travis@test.com", password: "password",
                     password_confirmation: "password", username: "travisvalentine",
                     location: "Washington, DC",
                     website: "tcvalentine.com", about: "Ginger")

test = User.create(email: "help@semantickit.com", password: "helptest",
                     password_confirmation: "helptest", username: "semantictest",
                     location: "Washington, DC",
                     website: "semantickit.com", about: "Testing")

#####################
### Create Categories
#####################
category_names = [ "Admin / Dashboard", "Corporate", "Portfolio", "Resume",
                   "Landing Page", "E-commerce", "Blog", "Components" ]

category_names.each do |category_name|
  Category.create!(name: category_name, slug: category_name.parameterize)
end

#####################
### Create Themes
#####################

theme_one   = {name: "Theme One", description: "An admin theme"}
theme_two   = {name: "Theme Two", description: "A portfolio theme"}
theme_three = {name: "Theme Three", description: "A resume theme"}

single = [5.99, 7.99, 9.99]
multiple = [13.00, 15.00, 18.00]
extended = [200.00, 300.00, 400.00]

[ theme_one, theme_two, theme_three ].each_with_index do |theme, index|
  theme = Theme.create(name: theme[:name], description: theme[:description], approved: true)
  theme.save(validate: false)
  # create theme categories
  theme.theme_categories.create!(category_id: Category.all.sample.id)
  # create theme price_list
  theme.create_price_list!(single_tier: single[index], multiple_tier: multiple[index], extended_tier: extended[index])
end

#####################
### Create Theme Owners
#####################

Theme.first(2).each do |t|
  t.create_owner(user_id: will.id)
end
Theme.last.create_owner(user_id: travis.id)

puts "All done! Success"