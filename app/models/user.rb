class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, length: { in: 6..20 }, on: :create
  after_destroy :notify_user

  def full_name
    "#{firstname} #{lastname}"
  end

  def notify_user
    binding.pry
    UserMailer.goodbye_email(self).deliver
  end

end
