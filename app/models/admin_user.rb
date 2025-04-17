class AdminUser < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  
  # For tracking login activity
  def update_last_login
    update_column(:last_login_at, Time.current)
  end
end 