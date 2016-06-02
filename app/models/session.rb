class Session < ActiveRecord::Base
  validates :user_id, :session_token, :environment, :location, presence: true
  validate :user_exists

  after_initialize :ensure_session_token

  belongs_to :user

  def user_exists
    User.exists?(id: user_id)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end


end
