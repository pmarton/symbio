Factory.define :user do |u|
  u.name "Simple User"
  u.email "user@hoefler.st"
  u.password "test123"
  u.password_confirmation "test123"
  u.confirmed_at Time.current
end

Factory.define :admin, :class => User do |u|
  u.name "Uber Admin"
  u.email "admin@hoefler.st"
  u.password "test123"
  u.password_confirmation "test123"
  u.confirmed_at Time.current
end

Factory.define :salad, :class => MenuItem do |s|
  s.date "2011-06-27"
  s.name "Gemischter Salat mit Kernöldressing"
  s.meal_category_id 6
  s.sort_order 6
  s.price 3.0
end
