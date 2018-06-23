class Ride < ApplicationRecord
  # ------------ #
  # associations #
  # ------------ #
  has_many :quueues


  # ------ #
  # scopes #
  # ------ #


  # ----------- #
  # validations #
  # ----------- #
  validates_format_of :max_allowed_queue_code, with: /\A[A-Z]{5}\z/, message: "must be five upper case letters"
  validates_numericality_of :carts_on_track, :greater_than_or_equal_to => 0, :only_integer => true
  validates_numericality_of :ride_duration, :greater_than => 0, :only_integer => true
  validates_numericality_of :cart_occupancy, :greater_than => 0, :only_integer => true
  validates_numericality_of :min_height, :greater_than => 0, :only_integer => true


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
    self.max_allowed_queue_code = "AAAAA"
    self.save
  end


  # ----------------- #
  # private functions #
  # ----------------- #
end
