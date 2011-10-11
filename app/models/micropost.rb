class Micropost < ActiveRecord::Base

 attr_accessible :content, :data  
 belongs_to :user
  
 paginates_per 10
 
 validates :content, :presence => true, :length => { :maximum => 140 }
 validates :user_id, :presence => true
 
 default_scope :order => 'microposts.created_at DESC' 

end
