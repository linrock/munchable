class User < ActiveRecord::Base
  validates_presence_of  :password

  devise :database_authentication,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable
end
