class Quueue < ApplicationRecord
  # ------------ #
  # associations #
  # ------------ #
  belongs_to :visit
  belongs_to :ride

  # ------ #
  # scopes #
  # ------ #
  scope :alphabetical, -> { order('queue_code') }
  scope :are_checked_in, -> { where(checked_in: true) }
  scope :are_not_checked_in, -> { where(checked_in: false) }
  scope :today, -> { where("created_at >= ?", Date.today.beginning_of_day) }
  scope :on_date, ->(date) { where("created_at >= ? AND created_at <= ?", date.beginning_of_day, date.end_of_day) }
  scope :all_past, -> { where("created_at < ?", Date.today.beginning_of_day) }


  # ----------- #
  # validations #
  # ----------- #
  validates_presence_of :ride_id, :visit_id, :queue_code, :security_code
  validates_format_of :queue_code, with: /\A[A-Z]{4}\z/, message: "must be four upper case letters"
  validates_format_of :security_code, with: /\A[A-Z]{20}\z/, message: "must be twenty upper case letters"
  validate :cant_check_in_without_is_ready
  validate :ride_must_allow_queue
  validate :cannot_be_in_two_lines_at_once, :on => :create


  # --------- #
  # callbacks #
  # --------- #
  before_validation :create_queue_code, :create_security_code


  # ---------------- #
  # public functions #
  # ---------------- #
  def is_ready?
    self.queue_code <= self.ride.max_allowed_queue_code && (self.created_at.nil? || self.created_at.to_date == Date.today)
  end


  # ----------------- #
  # private functions #
  # ----------------- #
  private
  def cannot_be_in_two_lines_at_once
    unless self.visit.nil?
      current_line = self.visit.quueues.today.are_not_checked_in.first
      unless current_line.nil?
        errors.add(:base, 'rider cannot be in two lines at once')
      end
    end
  end

  def cant_check_in_without_is_ready
    if self.checked_in && !self.is_ready?
      errors.add(:base, "rider is not ready to check in yet")
    end
  end

  def ride_must_allow_queue
    unless self.ride.nil? || self.ride.allow_queue
      errors.add(:ride, "is not allowing queues at this time")
    end
  end

  def create_queue_code
    # ensure self.ride and self.visit are defined
    unless self.ride.nil? || self.visit.nil?
      # check if this object needs a queue_code
      if self.queue_code.nil? || self.queue_code == ''
        last_queue_for_ride = self.ride.quueues.alphabetical.last

        # special case for the first queue
        if last_queue_for_ride.nil?
          self.queue_code = 'AAAA'
        else
          self.queue_code = last_queue_for_ride.queue_code.next
        end
      end
    end
  end

  def create_security_code
    # ensure self.ride and self.visit are defined
    unless self.ride.nil? || self.visit.nil?
      if self.security_code.nil? || self.security_code == ''
        self.security_code = Array.new(20){[*"A".."Z"].sample}.join
      end
    end
  end
end
