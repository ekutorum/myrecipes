require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "Cameron", email: "cameron@notcameron.com",
                     password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname should be less than 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end
  
  test "email should be valid" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email should not be too long" do
    @chef.email = "a" * 245 + "@example.com"
    assert_not @chef.valid?
  end

  test "email should accept correct format" do
    valid_emails = %w[user@example.com Mashur@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |v_email|
      @chef.email = v_email
      assert @chef.valid?, "#{v_email.inspect} should be valid"
    end
  end
  
  test "should reject invalid emails" do
    invalid_emails = %w[mashur@example mashur@example,com qw.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |iv_email|
      @chef.email = iv_email
      assert_not @chef.valid?, "#{iv_email.inspect} should be invalid"
    end
  end
  
  test "email should be unique and case-insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  
  test "email should be lowercase before hitting db" do
    mixed_email = "JohnN@ExaMple.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end
  
  test "password should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end

  test "password should be at least 5 characters" do
    @chef.password = @chef.password_confirmation = "x" * 4
    assert_not @chef.valid?
  end
  
end