class Micropost < ActiveRecord::Base

 attr_accessible :content, :calendar_date
 belongs_to :user

 paginates_per 10

 validates :content, :presence => true, :length => { :maximum => 140 }
 validates :user_id, :presence => true
 validates :calendar_date, :presence => true

 default_scope where('calendar_date')
 scope :may, :order => "calendar_date ASC", :select => :calendar_date
 scope :events_for, lambda { |date| where("calendar_date = ?", date) }

end
