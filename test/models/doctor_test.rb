require 'test_helper'

class DoctorTest < ActiveSupport::TestCase
  
  def setup
    @doctor = Doctor.new(fname: "Example", lname: "User", email: "user@example.com",
                     password: "123hello", password_confirmation: "123hello")
  end
  test "should be valid" do
    assert @doctor.valid?
  end
  test "lname should be present" do
    @doctor.lname = "     "
    assert_not @doctor.valid?
  end
  test "fname should be present" do
    @doctor.fname = "     "
    assert_not @doctor.valid?
  end
  test "email should be present" do
    @doctor.email = "     "
    assert_not @doctor.valid?
  end
  test "first name should not be too long" do
    @doctor.fname = "a" * 22
    assert_not @doctor.valid?
  end
  test "last name should not be too long" do
    @doctor.lname = "a" * 22
    assert_not @doctor.valid?
  end
  test "email should not be too long" do
    @doctor.email = "a" * 244 + "@example.com"
    assert_not @doctor.valid?
  end
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @doctor.email = invalid_address
      assert_not @doctor.valid?, "#{invalid_address.inspect} should be invalid"
  end
  test "email addresses has to be unique" do
      duplicate_doctor = @doctor.
      duplicate_doctor.email = @doctor.email.upcase
      @doctor.save
      assert_not duplicate_doctor.valid?
  end
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  test "password should be present (nonblank)" do
    @doctor.password = @doctor.password_confirmation = " " * 6
    assert_not @doctor.valid?
  end

  test "password should have a minimum length" do
    @doctor.password = @doctor.password_confirmation = "a" * 5
    assert_not @doctor.valid?
  end
  end
end
