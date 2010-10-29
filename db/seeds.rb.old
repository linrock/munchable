# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require RAILS_ROOT + '/db/generator'


Location.create([{
  :city => 'San Francisco',
  :state => 'CA',
  :zoom_level => 12,
  :x_center => 37.7547,
  :y_center => -122.4426,
  :x_lower => 37.6946877,
  :x_upper => 37.8116826,
  :y_lower => -122.5233078,
  :y_upper => -122.3550796
},{
  :city => 'Mountain View',
  :state => 'CA',
  :zoom_level => 15,
  :x_center => 37.390414,
  :y_center => -122.080936,
  :x_lower => 37.383116,
  :x_upper => 37.395221,
  :y_lower => -122.091879,
  :y_upper => -122.070637,
}])


fng = FakeNameGenerator.new

places = []
places.push File.open(RAILS_ROOT + '/db/places/ca_san_francisco.txt').read.split(/\n/)
places.push File.open(RAILS_ROOT + '/db/places/ca_mountain_view.txt').read.split(/\n/)
places.flatten!

File.open(RAILS_ROOT + '/db/categories/food.txt').read.split(/\n/).each do |c|
  Category.create(:name => c)
end
File.open(RAILS_ROOT + '/db/categories/restaurants.txt').read.split(/\n/).each do |c|
  Category.create(:name => c)
end

=begin
    r = Restaurant.create({
      :location_id => Location.get_location(row[4], row[5]).id,
      :url => row[0],
      :name => row[1],
      :categories => row[3],
      :rating => row[6],
      :review_count => row[7],
      :address => row[8],
      :website => row[9],
      :hours => row[10],
      :good_for => row[11],
      :delivery => row[12],
      :take_out => row[13],
      :x => row[4],
      :y => row[5],
      :updated_at => row[14]
    })
=end
=begin
    (rand*10).to_i.times do
      MenuItem.create(
        :restaurant_id => r.id,
        :name => fng.generate_name(row[3]),
        :price => (rand*20).to_i
      )
    end
=end

def quote (str)
  str.gsub(/\\|'/) { |c| "\\#{c}" }
end

inserts = []
places.each do |row|
  row = row.split '|'
  row = row.map{|r| quote(r)}

  delivery = row[12].empty? ? 0 : 1
  take_out = row[13].empty? ? 0 : 1
  inserts.push "('#{Location.get_location(row[4], row[5]).id}', E'#{row[0]}', E'#{row[1]}', E'#{row[3]}', '#{row[6]}', '#{row[7]}', E'#{row[8]}', '#{row[9]}', E'#{row[10]}', E'#{row[11]}', '#{delivery}', '#{take_out}', '#{row[4]}', '#{row[5]}', '#{row[14]}')"
end

sql = "INSERT INTO restaurants (location_id, url, name, categories, rating, review_count, address, website, hours, good_for, delivery, take_out, x, y, updated_at) VALUES #{inserts.join(', ')}"
Restaurant.connection.execute sql

=begin
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
=end
