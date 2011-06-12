class Micropost < ActiveRecord::Base

 attr_accessible :content  
 belongs_to :user
  
 paginates_per 5
 
 validates :content, :presence => true, :length => { :maximum => 140 }
 validates :user_id, :presence => true
 
 default_scope :order => 'microposts.created_at DESC' 

end
