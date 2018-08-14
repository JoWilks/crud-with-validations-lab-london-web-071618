class Song < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates_inclusion_of :released, :in => [true, false]
  validates :release_year, presence: true, if: :released_true?
  validate :not_released_future?
  validates :artist_name, presence: true

  def released_true?
    released == true
  end

  def not_released_future?
    if release_year != nil && release_year > Date.today.year
      errors.add(:release_year, "can't be in the future")
    end
  end
end
