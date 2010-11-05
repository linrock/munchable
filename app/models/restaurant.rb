class Restaurant < ActiveRecord::Base
  belongs_to :location
  has_many :menu_items
  has_many :menu_comments
  has_many :comments
  has_many :lists, :through => :listings

  scope :within_bounds_xy, lambda {|bounds|
    where('x > ? AND x < ? AND y > ? AND y < ?',
      bounds['x'][0], bounds['x'][1], bounds['y'][0], bounds['y'][1]
    )
  }

  scope :within_bounds, lambda {|bounds|
    where('xy && ?', Polygon.from_coordinates([[
      [bounds['x'][0], bounds['y'][0]],
      [bounds['x'][1], bounds['y'][0]],
      [bounds['x'][1], bounds['y'][1]],
      [bounds['x'][0], bounds['y'][1]],
      [bounds['x'][0], bounds['y'][0]]
    ]], 4326))
  }

  scope :k_nearest, lambda {|center, k|
    if center.all? {|c| c.is_a? Numeric}
      order("ST_Distance(xy, ST_GeomFromText('#{'POINT(%f %f)' % center}', 4326))").limit(k)
    end
  }

  scope :relevant, lambda {|category|
    where("categories LIKE ?", ["%#{category}%"])
  }

  scope :limited, lambda { |k|
    order('rating DESC, review_count DESC').limit(k)
  }

  def self.get_nearest(bounds, center, category, max_num)
    self.relevant(category)
      .within_bounds(bounds)
      .k_nearest(center, max_num)
  end

  def self.get_best(bounds, category, max_num)
    self.relevant(category)
      .within_bounds(bounds)
      .limited(max_num)
  end
end
