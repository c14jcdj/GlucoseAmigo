class Record < ActiveRecord::Base

  attr_accessible :weight, :glucose, :taken_at, :comment
  belongs_to :diabetic

  validate :inclusion_of_weight_and_or_glucose, message: "Either glucose or weight is required."
  validate :taken_date_cannot_be_in_the_future, message: "Date taken cannot be in the future."
  validates_presence_of :taken_at, message: "Date taken must be present."
  validates :glucose, :inclusion => { :in => 1..500, :message => "Glucose must be between 1 and 500" }
  validates :weight, :inclusion => { :in => 1..1000, :message => "Weight must be between 1 and 1000" }


  def inclusion_of_weight_and_or_glucose
    unless (self.weight.present? || self.glucose.present?)
      errors.add(:weight, "Must include either weight or glucose")
      errors.add(:glucose, "Must include either weight or glucose")
    end
  end

  def taken_date_cannot_be_in_the_future
    if taken_at.present? && taken_at > (Time.now + 600)
      errors.add(:taken_at, "Time data was taken must be before now")
    end
  end

  def numericality_of_weight_and_glucose
    if (self.weight.to_i == 0 && self.glucose.to_i == 0)
      errors.add(:weight, "Weight must be an integer")
      errors.add(:glucose, "Glucose level must be an integer")
    end

  end




end
