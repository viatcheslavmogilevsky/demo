require 'digest'
class User < ActiveRecord::Base
 has_many :microposts, :dependent => :destroy
 has_many :events, :dependent => :destroy
 has_many :ign_items, :dependent => :destroy
 has_many :favorites, :dependent => :destroy
 has_many :received, :dependent => :destroy
 attr_accessor :password
 attr_accessible :name, :email, :password, :password_confirmation 
 scope :random, :order=>'RANDOM()', :limit=>1
 
  paginates_per 30

 email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

 validates :name, :presence => true,
	          :length => {:maximum => 30}
           
 validates :email, :presence => true,
                   :format => {:with => email_regex},
                   :uniqueness => {:case_sensitive => false}
 
 validates :password, :presence => true,
           :confirmation =>  true,
           :length => {:within => 6..40}
 before_save :encr_pass
 
 def feed
  Micropost.where("user_id = ?", id)
 end

 def has_password?(submitted_pass)
  enc_pass == enc(submitted_pass)
 end
  
 def self.authenticate(email, submitted_pass)
   user = find_by_email(email)
   return nil if user.nil?
   return user if user.has_password?(submitted_pass)
 end 

 def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
 end

 def receive_message(message)
  self.received_microposts.build(message)
 end

 private
  def enc(string)
	secure_hash("#{salt}--#{string}")
  end

  def encr_pass
        self.salt = make_salt if new_record?
	self.enc_pass = enc(password)
  end
  
  def make_salt
	secure_hash("#{Time.now.utc}--#{password}")
  end
  
  def secure_hash(string)
	 Digest::SHA2.hexdigest(string)
  end
 
end
