class Quueue < ApplicationRecord
  # ------------ #
  # associations #
  # ------------ #
  belongs_to :visit
  belongs_to :ride

  # ------ #
  # scopes #
  # ------ #


  # ----------- #
  # validations #
  # ----------- #
  validates_presence_of :ride_id, :visit_id, :queue_code, :security_code
  validates_format_of :queue_code, with: /\A[A-Z]{5}\z/, message: "must be five upper case letters"
  validates_format_of :security_code, with: /\A[A-Z]{20}\z/, message: "must be twenty upper case letters"


  # --------- #
  # callbacks #
  # --------- #


  # ---------------- #
  # public functions #
  # ---------------- #


  # ----------------- #
  # private functions #
  # ----------------- #
end
