# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# Create the admin role and user

if User.all.length == 0
  admin_user = User.create!(:id => 1, :name => "Site Administrator", :email => "admin@sym.bio", :password => "symbio", :password_confirmation => "symbio", :admin => true)
  regular_user = User.create!(:id => 2, :name => "Regular User", :email => "user@sym.bio", :password => "symbio", :password_confirmation => "symbio", :admin => false)
end

# Add dummy content, mainly for testing

# Meal categories
MealCategory.create(:id => 1, :name => 'Suppe', :sort_order => 10, :price => 2.0)
MealCategory.create(:id => 2, :name => 'Hauptgericht 1', :sort_order => 20, :price => 6.0)
MealCategory.create(:id => 3, :name => 'Hauptgericht 2', :sort_order => 22, :price => 6.0)
MealCategory.create(:id => 4, :name => 'Hauptgericht 3', :sort_order => 24, :price => 6.0)
MealCategory.create(:id => 5, :name => 'Indisch', :sort_order => 30, :price => 6.0)
MealCategory.create(:id => 6, :name => 'Salat', :sort_order => 40, :price => 3.0)
MealCategory.create(:id => 7, :name => 'Desert 1', :sort_order => 50, :price => 2.0)
MealCategory.create(:id => 8, :name => 'Desert 2', :sort_order => 52, :price => 2.0)