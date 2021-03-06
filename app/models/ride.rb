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
  validates_presence_of :ride_name, :ride_image_url, :carts_on_track, :ride_duration, :cart_occupancy, :max_allowed_queue_code, :min_height
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

  def expected_wait_time(queue_code=nil)
    if queue_code.nil?
      number_in_line = self.quueues.today.are_not_checked_in.length
      # accurately report empty lines
      return 0 if number_in_line <= 0
    else
      # prevents reporting waits when the code is actually ready
      return 0 if queue_code <= self.max_allowed_queue_code
      number_in_line = distance_between_queues(self.max_allowed_queue_code, queue_code)
    end
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
  def queue_to_number(queue_code)
    base = "A".ord
    i0 = (queue_code[0].ord - base) * (26 ** 3)
    i1 = (queue_code[1].ord - base) * (26 ** 2)
    i2 = (queue_code[2].ord - base) * (26 ** 1)
    i3 = (queue_code[3].ord - base) * (26 ** 0)
    return i0 + i1 + i2 + i3
  end
  def distance_between_queues(q1, q2)
    (queue_to_number(q1) - queue_to_number(q2)).abs
  end

  def ride_must_be_active_to_allow_queue
    if !self.active && self.allow_queue
      errors.add(:allow_queue, "cannot be on if ride is inactive")
    end
  end
end
