class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  validates_presence_of  :password

  has_one :profile
  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships
  has_many :lists, :through => :groups
  has_many :comments

  def create_group(name)
    g = Group.new({
      :user_id => self.id,
      :name => name,
    })
    if g.save
      Membership.create({
        :user_id => self.id,
        :group_id => g.id,
        :role => 'admin'
      })
      List.create({
        :user_id => self.id,
        :group_id => g.id
      })
      g
    else
      nil
    end
  end
end
