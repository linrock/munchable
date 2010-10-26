class Restaurant < ActiveRecord::Base
  has_many :menu_items
  has_many :menu_comments
  belongs_to :location
  has_and_belongs_to_many :categories, :join_table => 'restaurants_categories'

  @zone = "x > ? AND x < ? AND y > ? and y < ?"
  @categories = [
    'mexican',
    'bakeries',
    'desserts',
    'ice cream & frozen yogurt',
    'sandwiches',
    'food stands',
    'breakfast & brunch',
    'coffee & tea',
    'pizza',
    'american (traditional)',
    'american (new)',
    'delis',
    'burgers',
    'seafood',
    'diners',
    'italian',
    'hot dogs'
  ]
end
