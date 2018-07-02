require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:park_passes)
  should have_secure_password

  should validate_presence_of(:username)
  should validate_presence_of(:email)
  should validate_presence_of(:phone)
  should validate_presence_of(:role)

  should allow_value("admin").for(:role)
  should allow_value("visitor").for(:role)
  should_not allow_value("bad").for(:role)
  should_not allow_value("hacker").for(:role)
  should_not allow_value(10).for(:role)
  should_not allow_value("leader").for(:role)
  should_not allow_value(nil).for(:role)

  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)

  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  should_not allow_value(nil).for(:email)

  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)
  should_not allow_value(nil).for(:phone)

  context "Within context" do
    setup do
      create_users
    end

    teardown do
      delete_users
    end

    should "show that the alpabetical scope works as expected" do
      assert_equal(User.alphabetical.map(&:username), ['gkufro', 'jkufro', 'root', 'tkufro'])
    end

    should "require users to have unique, case-insensitive usernames" do
      assert_equal "jkufro", @justin.username

      @gail.username = "jkufro"
      deny @gail.valid?
    end

    should "allow user to authenticate with password" do
      assert @justin.authenticate("secret")
      deny @justin.authenticate("notsecret")
    end

    should "allow user to authenticate with username and password" do
      deny User.authenticate_username('jkufro', 'badpass')
      assert_not_nil User.authenticate_username('gkufro', 'secret')
      assert_not_nil User.authenticate_username('tkufro', 'secret')
      assert_not_nil User.authenticate_username('jkufro', 'secret')
    end

    should "allow user to authenticate with email and password" do
      deny User.authenticate_email('jkufro@example.com', 'badpass')
      assert_not_nil User.authenticate_email('jkufro@example.com', 'secret')
      assert_not_nil User.authenticate_email('tkufro@example.com', 'secret')
      assert_not_nil User.authenticate_email('gkufro@example.com', 'secret')
    end

    should "require a password for new users" do
      bad_user = FactoryBot.build(:user, username: "johnny", role: 'visitor', password: nil)
      deny bad_user.valid?
    end

    should "require password confirmation to match password" do
      bad_user_1 = FactoryBot.build(:user, username: "johnny", role: 'visitor', password: "secret", password_confirmation: nil)
      deny bad_user_1.valid?
      bad_user_2 = FactoryBot.build(:user, username: "johnnyboi", role: 'visitor', password: "secret", password_confirmation: "sauce")
      deny bad_user_2.valid?
      good_user = FactoryBot.build(:user, username: "johnnyboi", role: 'visitor', password: "secret", password_confirmation: "secret")
      assert good_user.valid?
    end

    should "require passwords to be at least four characters" do
      bad_user = FactoryBot.build(:user, username: "johnny", role: 'visitor', password: "no")
      deny bad_user.valid?
    end

    should "strip non-digits from the phone number" do
      @justin.phone = '(555) 123-4545'
      @justin.save
      assert_equal "5551234545", @justin.phone
    end

    ### TESTS NOT REQUIRED FOR PHASE 4
    should "have a role? method for authorization" do
      assert @admin.role?(:admin)
      assert @justin.role?(:visitor)
      assert @gail.role?(:visitor)
    end
  end
end
