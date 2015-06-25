class Movie < ActiveRecord::Base
  has_many :reviews
  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :image, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_future
  mount_uploader :image, ImageUploader

  def review_average
    if reviews.size != 0
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

    scope :search, ->(query) { where("title LIKE ? OR director LIKE ?", "%#{query}%", "%#{query}%") }
    scope :minutes_under_90, -> { where("runtime_in_minutes < 90") }
    scope :minutes_between_90_120, -> { where("runtime_in_minutes >= 90 AND runtime_in_minutes <= 120") }
    scope :minutes_over_120, -> { where("runtime_in_minutes > 120") }


protected
  def release_date_is_in_the_future
    if release_date.present?
    errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
