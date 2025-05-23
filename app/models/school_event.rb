class SchoolEvent < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def duration
    (end_date - start_date).to_i / 1.day
  end

  def upcoming?
    start_date > Time.current
  end

  def current?
    Time.current.between?(start_date, end_date)
  end
end
