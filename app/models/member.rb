class Member < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  # Optional phone validation
  validates :phone, format: { with: /\A\+?[\d\s\-\(\)]+\z/, allow_blank: true }
  
  # Martial arts specific fields
  validates :rank, presence: true
  validates :active, inclusion: { in: [true, false] }
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  # Scopes for filtering
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :ordered_by_name, -> { order(:last_name, :first_name) }
end 