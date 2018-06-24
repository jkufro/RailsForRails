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
  scope :all_past, -> { where(["created_at >= ? AND created_at <= ?", Date.today.beginning_of_day, date.end_of_day]) }


  # ----------- #
  # validations #
  # ----------- #
  validates_presence_of :ride_id, :visit_id, :queue_code, :security_code
  validates_format_of :queue_code, with: /\A[A-Z]{5}\z/, message: "must be five upper case letters"
  validates_format_of :security_code, with: /\A[A-Z]{20}\z/, message: "must be twenty upper case letters"
  validate :cant_check_in_without_is_ready


  # --------- #
  # callbacks #
  # --------- #


  # ---------------- #
  # public functions #
  # ---------------- #
  def is_ready?
    self.queue_code > self.ride.max_allowed_queue_code && self.created_at == Date.today.beginning_of_day
  end


  # ----------------- #
  # private functions #
  # ----------------- #
  private
  def cant_check_in_without_is_ready
    if self.checked_in && !self.is_ready?
      errors.add(:base, "rider is not ready to check in yet")
    end
  end
end
