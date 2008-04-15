require 'digest/sha1'

class User < ActiveRecord::Base
  
  has_many                    :articles
  
  validates_presence_of       :user_name
  validates_uniqueness_of     :user_name
  
  validates_confirmation_of   :password
  attr_accessor :password_confirmation
  
  def validate
    errors.add_to_base("Missing Password") if hashed_password.blank?
  end
  
  def self.authenticate(name, password)
    user = self.find_by_user_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  # 'password' is a virtual attribute
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  private
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "squ!zzlef@rt" + salt   # 'squ!zzlef@rt' makes it harder to guess
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
end
