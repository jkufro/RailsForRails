class ParkPass < ApplicationRecord
  # ------------ #
  # associations #
  # ------------ #
  belongs_to :pass_type
  belongs_to :user
  has_many :visits
  has_many :quueues, through: :visits


  # ------ #
  # scopes #
  # ------ #


  # ----------- #
  # validations #
  # ----------- #
  validates_presence_of :user_id, :pass_type_id, :first_name, :last_name, :card_number, :card_expiration
  validates_uniqueness_of :card_number
  validates_format_of :card_number, with: /\A[A-Z]\d{15}\z/, message: "is not a valid format"
  validates_timeliness_of :card_expiration, :on => :create, :on_or_after => :today, :message => "must be today or in the future"


  # --------- #
  # callbacks #
  # --------- #


  # ---------------- #
  # public functions #
  # ---------------- #
  def expired?
    self.card_expiration >= Date.today
  end

  def ridden_rides
    rides = []
    self.visits.each{ |v| rides << v.ridden_rides }
    return rides
  end

  def ridden_rides_summary
    summary = Hash.new(0)
    rides = self.ridden_rides
    rides.each{ |r| summary[r.ride_name] += 1}
    return summary
  end

  def at_park?
    !self.visits.today.nil?
  end


  # ----------------- #
  # private functions #
  # ----------------- #
end
