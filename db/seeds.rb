# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

File.open(RAILS_ROOT + '/db/data.txt').read.split(/\n/)[1..-1].each do |r|
  r = r.split(/\t/)
  Restaurant.create({
    :url => r[0],
    :name => r[1],
    :rating => r[2],
    :review_count => r[3],
    :address => r[4],
    :categories => r[5],
    :coordinates => r[6],
    :updated_at => r[7]
  })
end

MenuItem.create([{
  :restaurant_id => 1,
  :name => 'Fuji Apples',
  :description => 'Amazingly tasty apples',
  :price => '$2/lb'
},{
  :restaurant_id => 1,
  :name => 'Home-made Pound Cake',
  :description => 'Freshly baked daily',
  :price => '$2/lb'
}])

c0 = MenuComment.create({
  :restaurant_id => 1,
  :menu_item_id => 1,
  :content => "i've gotta say that these have got to be the best apples ever!",
})
c1 = MenuComment.create({
  :restaurant_id => 1,
  :menu_item_id => 1,
  :parent_id => c0.id,
  :content => "how bout dem apples?!"
})
c2 = MenuComment.create({
  :restaurant_id => 1,
  :menu_item_id => 1,
  :parent_id => c1.id,
  :content => "lol are these apples really that special?"
})
