class User < ActiveRecord::Base
  attr_reader :password

  has_many :cats
  has_many :cat_rental_requests
  has_many :sessions

  validates :user_name, presence: true, uniqueness: true  #:session_token, for single
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true }

  # after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  # def reset_session_token!
  #   token = SecureRandom::urlsafe_base64
  #   self.session_token = token
  #   self.save
  #   token
  # end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = self.find_by(user_name: user_name)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  # protected
  # def ensure_session_token
  #   #check if it exists, if not, generate session token
  #   self.session_token ||= SecureRandom::urlsafe_base64
  # end

end
