class Admin < ActiveRecord::Base
  after_destroy :notify_user

  protected
  def notify_user
    binding.pry
    UserMailer.goodbye_email(self).deliver
  end
end
