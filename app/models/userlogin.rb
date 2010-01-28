require 'digest/sha1'

class Userlogin < ActiveRecord::Base

  validates_presence_of :login
  validates_length_of :login, :within => 3..40
  validates_uniqueness_of :login
  validates_presence_of     :password
  validates_length_of       :password, :within => 4..40
 
  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :password, :sites
 
  # Authenticates a user by their login name and unencrypted password. Returns the user or nil.
  #
  # uff. this is really an authorization, not authentication routine.
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
 
  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def to_liquid()
    UserloginDrop.new self
  end

#  def password=(value)
#    write_attribute :password, value
#  end 
end
