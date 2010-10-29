class Restaurant < ActiveRecord::Base
  has_many :menu_items
  has_many :menu_comments
  belongs_to :location

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

  scope :k_nearest, lambda {|bounds, k|
    center = [(bounds['x'][0] + bounds['x'][1])/2, (bounds['y'][0] + bounds['y'][1])/2]
    order("ST_Distance(xy, ST_GeomFromText('#{'POINT(%f %f)' % center}', 4326))").limit(k)
  }

  scope :relevant, lambda {|category|
    where("categories LIKE ?", ["%#{category}%"])
  }

  scope :limited, lambda { |k|
    order('rating DESC, review_count DESC').limit(k)
  }

  def self.get_nearest(bounds, category, max_num)
    self.relevant(category)
      .within_bounds(bounds)
      .k_nearest(bounds, max_num)
      .sort_by{|c| [c[:rating], c[:review_count]]}.reverse
  end

  def self.get_best(bounds, category, max_num)
    self.relevant(category)
      .within_bounds(bounds)
      .limited(max_num)
  end
end
