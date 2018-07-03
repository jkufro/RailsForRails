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
  scope :non_expired, ->{ where("card_expiration >= ?", Date.today) }


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
  before_validation :create_card_number


  # ---------------- #
  # public functions #
  # ---------------- #
  def expired?
    self.card_expiration < Date.today
  end

  def ridden_rides
    rides = []
    self.visits.each{ |v| rides << v.ridden_rides }
    return rides.flatten
  end

  def ridden_rides_summary
    summary = Hash.new(0)
    rides = self.ridden_rides
    rides.each{ |r| summary[r.ride_name] += 1}
    return summary
  end

  def at_park?
    !(self.visits.today == [])
  end

  def current_queue
    todays_visit = self.visits.today
    unless todays_visit == []
        todays_visit = todays_visit.first
        cur_queue = todays_visit.current_queue
        return nil if cur_queue.nil?
        return cur_queue
    end
    return nil
  end

  # ----------------- #
  # private functions #
  # ----------------- #
  private
  def create_card_number
    unless self.user.nil?
      if self.card_number.nil? || self.card_number == ''
        self.card_number = [*'A'..'Z'].sample + rand(10 ** 15).to_s.rjust(15,'0')
      end
    end
  end
end
