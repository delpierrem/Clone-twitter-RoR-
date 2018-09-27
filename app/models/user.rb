class User < ApplicationRecord
  attr_accessor :remember_token

  before_save { self.email = email.downcase }
  validates  :name, presence: true, length: {maximum: 50}
  validates :email, :presence => true,
                    length: {maximum: 255},
                    :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
                    uniqueness: {case_sensitive: false}

  has_secure_password

  validates  :password, presence: true, length: {minimum: 6}

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    Bcrypt::password.new(remember_token).is_password?(remember_token)
  end

end
