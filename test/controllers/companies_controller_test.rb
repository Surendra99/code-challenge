require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "NewYork, TN"
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "523155")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@test.com")
      click_button "Update Company"
    end

    assert_text I18n.t('company.invalid_email')
    assert_text I18n.t('company.invalid_zip_code')

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      fill_in("company_email", with: 'mainstreet@getmainstreet.com')
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "523155")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@test.com")
      click_button "Create Company"
    end

    assert_text I18n.t('company.invalid_email')
    assert_text I18n.t('company.invalid_zip_code')

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "93003")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "93003", last_company.zip_code
  end

  test "Destroy" do
    name = @company.name
    visit company_path(@company)
    dismiss_confirm do
      click_link "Delete"
    end

    assert_text "#{name}"
    assert Company.find_by_id(@company.id).present?
    
    assert_text "Hometown Painting"
    accept_confirm do
      click_link "Delete"
    end
    assert_text I18n.t('company.successfully_deleted', name: name)
    assert Company.find_by_id(@company.id).nil?
  end

end
