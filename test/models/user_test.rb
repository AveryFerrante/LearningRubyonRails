require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test", email: "a@b.com", password: "testttttt", password_confirmation: "testttttt")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be valid" do
    valid_email_list = %w[valid@email.com AnotherValid@supervalid.com EXTREMELYVALID@phony.com]
    valid_email_list.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address} should be a valid email address"
    end
  end

  test "email should reject invalid address" do
    invalid_email_list = %w[invalid_address invaladdress@@mail.com NotValid@thing shouldntwork@somethingorg]
    invalid_email_list.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address} should be invalid"
    end
  end

  test "email should be saved in database as lowercase" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = "   "
    assert_not @user.valid?
  end

  test "password should be longer than 6 characters" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
