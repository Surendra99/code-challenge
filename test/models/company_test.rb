require "test_helper"
class CompanyTest < ActiveSupport::TestCase
    test "should allow blank email" do
        company = Company.new(name: "MainStreet", zip_code: "85001")
        assert company.valid?
    end

    test "should raise error for non getmainstreet.com email" do
      company = Company.new(name: "MainStreet", email: "mainStreet@main.com", zip_code: "93003")
      refute company.valid?
      assert_includes company.errors[:email].compact.join(''), I18n.t('company.invalid_email')
    end

    test "should allow getmainstreet domain email" do
      company = Company.new(name: "MainStreet", email: "mainStreet@getmainstreet.com", zip_code: "93003")
      assert company.valid?
    end

    test "should add error to zip_code attr if zip_code is not valid" do
      company = Company.new(name: "MainStreet", email: "mainStreet@getmainstreet.com", zip_code: "523155")
      company.valid?
      assert_includes company.errors[:zip_code].compact.join(''), I18n.t('company.invalid_zip_code')
      
      company = Company.new(name: "MainStreet", email: "mainStreet@getmainstreet.com", zip_code: "")
      company.valid?
      assert_includes company.errors[:zip_code].compact.join(''), I18n.t('company.invalid_zip_code')
      assert company.new_record?
    end
end