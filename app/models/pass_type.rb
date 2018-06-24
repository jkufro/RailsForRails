class PassType < ApplicationRecord
  # ------------ #
  # associations #
  # ------------ #
  has_many :park_passes


  # ------ #
  # scopes #
  # ------ #


  # ----------- #
  # validations #
  # ----------- #
  validates_presence_of :pass_name


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
