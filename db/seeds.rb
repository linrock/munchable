# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require RAILS_ROOT + '/db/generator'

fng = FakeNameGenerator.new
File.open(RAILS_ROOT + '/db/data.txt').read.split(/\n/)[1..1000].each do |row|
  row = row.split(/\t/)

  coordinates = JSON.load row[6]
  categories = []
  for c in JSON.load(row[5]) do
    c = c.downcase
    check = Category.where(:name => c).first
    if check
      categories << check
    else
      categories << Category.create(:name => c)
    end
  end
  r = Restaurant.create({
    :url => row[0],
    :name => row[1],
    :rating => row[2],
    :review_count => row[3],
    :address => row[4],
    :categories => categories,
    :x => coordinates[0],
    :y => coordinates[1],
    :updated_at => row[7]
  })
  stuff = []
  (rand*10).to_i.times do
    MenuItem.create(
      :restaurant_id => r.id,
      :name => fng.generate_name(r.categories),
      :price => (rand*20).to_i
    )
  end
end


m0 = MenuItem.create([{
  :restaurant_id => 1,
  :name => 'Submarine Sandwich',
  :description => 'Sinks like a sub in your stomach',
  :price => '$5'
},{
  :restaurant_id => 1,
  :name => 'History Hoagie',
  :description => 'The best hoagie in all of history',
  :price => '$7'
}])

c0 = MenuComment.create({
  :restaurant_id => 1,
  :menu_item_id => m0[0].id,
  :content => "dood this sandwich is the shiznit!",
})
c1 = MenuComment.create({
  :restaurant_id => 1,
  :menu_item_id => m0[0].id,
  :parent_id => c0.id,
  :content => "man, never had anything better!"
})
c2 = MenuComment.create({
  :restaurant_id => 1,
  :menu_item_id => m0[0].id,
  :parent_id => c1.id,
  :content => "amen brothah!!"
})

m1 = MenuItem.create([{
  :restaurant_id => 2,
  :name => 'Bacon Cheeseburger',
  :description => 'Delicious strips of bacon in every bite',
  :price => '$10'
},{
  :restaurant_id => 2,
  :name => 'Grilled Cheese Sandwich',
  :description => 'Grilled to perfection',
  :price => '$8'
},{
  :restaurant_id => 2,
  :name => 'Hickory Smoked Burger',
  :description => 'Delightful hickory-smoked beef',
  :price => '$7'
}])
c0 = MenuComment.create({
  :restaurant_id => 2,
  :menu_item_id => m1[0].id,
  :content => "hey, where's the downvote button?? this entry doesn't exist!"
})

m2 = MenuItem.create([{
  :restaurant_id => 3,
  :name => 'Petite Reuben',
  :description => 'Tiny little Reuben, but worth every penny',
  :price => '$20'
},{
  :restaurant_id => 3,
  :name => 'Petite Smokin Sandwich',
  :description => 'Smokin good, and to perfection',
  :price => '$14'
},{
  :restaurant_id => 3,
  :name => 'Tiny Burger',
  :description => 'Small, but delicious',
  :price => '$7'
}])
c0 = MenuComment.create({
  :restaurant_id => 3,
  :menu_item_id => m2[0].id,
  :content => "kind of expensive for such a tiny reuben, but it aint so bad"
})
