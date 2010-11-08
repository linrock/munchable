# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

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
},{
  :city => 'Washington DC',
  :state => '',
  :zoom_level => 12,
  :x_center => 38.900385,
  :y_center => -77.014503
}])

User.create({
  :email => 'root@you.com',
  :password => 'asdfasdf',
  :password_confirmation => 'asdfasdf'
})
User.create({
  :email => 'noob0@lol.com',
  :password => 'asdfasdf',
  :password_confirmation => 'asdfasdf'
})
User.create({
  :email => 'noob1@lol.com',
  :password => 'asdfasdf',
  :password_confirmation => 'asdfasdf'
})
User.create({
  :email => 'noob2@lol.com',
  :password => 'asdfasdf',
  :password_confirmation => 'asdfasdf'
})

# places = []
# places.push File.open(RAILS_ROOT + '/db/places/ca_san_francisco.txt').read.split(/\n/)
# places.push File.open(RAILS_ROOT + '/db/places/ca_mountain_view.txt').read.split(/\n/)
# places.flatten!


File.open(RAILS_ROOT + '/db/categories/food.txt').read.split(/\n/).each do |c|
  Category.create(:name => c)
end
File.open(RAILS_ROOT + '/db/categories/restaurants.txt').read.split(/\n/).each do |c|
  Category.create(:name => c)
end

def quote (str)
  str.gsub(/\\|'/) { |c| "\\#{c}" }
end

puts 'Loading data.txt...'
inserts = []
places = File.open(RAILS_ROOT + '/db/data.txt').read.split(/\n/)
places.each do |row|
  row = row.split '|'
  row = row.map{|r| quote(r)}

  # location = Location.get_location(row[4], row[5])
  # location = location.nil? ? 0 : location.id
  location = 0

  delivery = row[12].empty? ? 0 : (row[12] == 'f' ? 0 : 1)
  take_out = row[13].empty? ? 0 : (row[13] == 'f' ? 0 : 1)

  inserts.push "('#{location}', E'#{row[0]}', E'#{row[1]}', E'#{row[3]}', '#{row[6]}', '#{row[7]}', E'#{row[8]}', '#{row[9]}', E'#{row[10]}', E'#{row[11]}', '#{delivery}', '#{take_out}', #{row[4]}, #{row[5]}, ST_GeometryFromText('POINT(#{row[4]} #{row[5]})', 4326), '#{row[14]}')"
end

puts 'Inserting into DB...'
sql = "INSERT INTO restaurants (location_id, url, name, categories, rating, review_count, address, website, hours, good_for, delivery, take_out, x, y, xy, updated_at) VALUES #{inserts.join(', ')}"
Restaurant.connection.execute sql
