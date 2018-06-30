class User < ApplicationRecord
  # ------------ #
  # associations #
  # ------------ #
  has_many :park_passes

  # use has_secure_password for password hashing
  has_secure_password


  # ------ #
  # scopes #
  # ------ #


  # ----------- #
  # validations #
  # ----------- #
  validates_presence_of :email, :role
  validates :username, presence: true, uniqueness: { case_sensitive: false}
  validates :role, inclusion: { in: %w[admin visitor], message: "is not a recognized role in system" }
  validates_presence_of :password, on: :create
  validates_presence_of :password_confirmation, on: :create
  validates_confirmation_of :password, message: "does not match"
  validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true
  validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes or dots"
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil))\z/i, message: "is not a valid format"


  # --------- #
  # callbacks #
  # --------- #
  before_save :reformat_phone


  # ---------------- #
  # public functions #
  # ---------------- #
  def self.authenticate_email(email,password)
    # allow someone to authenticate using an email and password
    find_by_email(email).try(:authenticate, password)
  end

  def self.authenticate_username(username,password)
    # allows someone to authenticate using a username and password
    find_by_username(username).try(:authenticate, password)
  end


  # ----------------- #
  # private functions #
  # ----------------- #
  private
  def reformat_phone
    # Only take the numbers out of the phone number given to us
    # and set self.phone as the new value
    self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
  end
end
