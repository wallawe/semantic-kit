User.delete_all
Category.delete_all
Theme.delete_all


#####################
### Create Users
#####################

will = User.create(email: "will@test.com", password: "password",
                   password_confirmation: "password", username: "wallacewe",
                   name: "Will Wallace", location: "Arlington, VA",
                   website: "wallace.com", about: "Awesome")

travis = User.create(email: "travis@test.com", password: "password",
                     password_confirmation: "password", username: "travisvalentine",
                     name: "Travis Valentine", location: "Washington, DC",
                     website: "tcvalentine.com", about: "Ginger")

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

theme_one   = {name: "Theme One", description: "An admin theme", copyright: "2014"}
theme_two   = {name: "Theme Two", description: "A portfolio theme", copyright: "2014"}
theme_three = {name: "Theme Three", description: "A resume theme", copyright: "2014"}

[ theme_one, theme_two, theme_three ].each do |theme|
  theme = Theme.create(name: theme[:name], description: theme[:description], copyright: theme[:copyright])
  theme.theme_categories.create(category_id: Category.all.sample.id)
end

Theme.first.create_owner(user_id: will.id)
Theme.last.create_owner(user_id: travis.id)