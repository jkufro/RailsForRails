class Ride < ApplicationRecord
  # ------------ #
  # associations #
  # ------------ #
  has_many :quueues


  # ------ #
  # scopes #
  # ------ #
  scope :alphabetical, -> { order('ride_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :allow_queue, -> { where(allow_queue: true) }
  scope :doesnt_allow_queue, -> { where(allow_queue: false) }


  # ----------- #
  # validations #
  # ----------- #
  validates_presence_of :ride_name, :carts_on_track, :ride_duration, :cart_occupancy, :max_allowed_queue_code, :min_height
  validates_format_of :max_allowed_queue_code, with: /\A[A-Z]{4}\z/, message: "must be four upper case letters"
  validates_numericality_of :carts_on_track, :greater_than_or_equal_to => 0, :only_integer => true
  validates_numericality_of :ride_duration, :greater_than => 0, :only_integer => true
  validates_numericality_of :cart_occupancy, :greater_than => 0, :only_integer => true
  validates_numericality_of :min_height, :greater_than => 0, :only_integer => true
  validate :ride_must_be_active_to_allow_queue


  # --------- #
  # callbacks #
  # --------- #


  # ---------------- #
  # public functions #
  # ---------------- #
  def increment_queue
    self.max_allowed_queue_code = self.max_allowed_queue_code.next
    self.save
  end

  def call_queue(num_guests_to_call)
    (1..num_guests_to_call).each {
      self.max_allowed_queue_code = self.max_allowed_queue_code.next
    }
    self.save
  end

  def reset_queue
    self.max_allowed_queue_code = "AAAA"
    self.save
  end

  def ready_queues
    self.quueues.today.select{ |q| q.is_ready? }
  end

  def unready_queues
    self.quueues.today.select{ |q| !q.is_ready? }
  end

  def checked_in_queues
    self.quueues.are_checked_in
  end

  def expected_wait_time
    number_in_line = self.unready_queues.length
    time_between_carts = self.ride_duration / self.carts_on_track

    carts_before_empty_line = number_in_line / self.cart_occupancy
    # correct any error from integer division
    carts_before_empty_line += 1 if number_in_line % self.cart_occupancy != 0

    seconds_wait_time = carts_before_empty_line * time_between_carts
    minutes_wait_time = seconds_wait_time / 60
    return minutes_wait_time
  end

  # ----------------- #
  # private functions #
  # ----------------- #
  private
  def ride_must_be_active_to_allow_queue
    if !self.active && self.allow_queue
      errors.add(:allow_queue, "cannot be on if ride is inactive")
    end
  end
end
