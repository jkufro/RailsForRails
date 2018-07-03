class Visit < ApplicationRecord
  # ------------ #
  # associations #
  # ------------ #
  belongs_to :park_pass
  has_many :quueues


  # ------ #
  # scopes #
  # ------ #
  scope :today, -> { where(visit_date: Date.today) }


  # ----------- #
  # validations #
  # ----------- #
  validates_presence_of :visit_date, :park_pass_id
  validates_timeliness_of :visit_date, :on => :create, :is_at => Date.today
  validate :pass_cannot_be_expired, :on => :create


  # --------- #
  # callbacks #
  # --------- #


  # ---------------- #
  # public functions #
  # ---------------- #
  def ridden_rides
    self.quueues.are_checked_in.map{ |q| q.ride }
  end

  def ridden_rides_summary
    summary = Hash.new(0)
    rides = self.ridden_rides
    rides.each{ |r| summary[r.ride_name] += 1}
    return summary
  end

  def current_queue
    latest = self.quueues.last
    unless latest.nil? || latest.checked_in
      return latest
    end
  end


  # ----------------- #
  # private functions #
  # ----------------- #
  private
  def pass_cannot_be_expired
    unless self.park_pass.nil?
      if self.park_pass.expired?
        errors.add(:park_pass, "is expired")
      end
    end
  end
end
