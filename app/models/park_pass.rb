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


  # ----------------- #
  # private functions #
  # ----------------- #
end
