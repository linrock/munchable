class Group < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships

  def members
    uids = self.memberships.all(:select => :user_id).collect {|m| m.user_id }.uniq
    User.all(:conditions => "id IN (#{uids.join(',')})")
  end
end
