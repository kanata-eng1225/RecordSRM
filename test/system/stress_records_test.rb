require "application_system_test_case"

class StressRecordsTest < ApplicationSystemTestCase
  setup do
    @stress_record = stress_records(:one)
  end

  test "visiting the index" do
    visit stress_records_url
    assert_selector "h1", text: "Stress records"
  end

  test "should create stress record" do
    visit stress_records_url
    click_on "New stress record"

    fill_in "After stress level", with: @stress_record.after_stress_level
    fill_in "Before stress level", with: @stress_record.before_stress_level
    fill_in "Detail", with: @stress_record.detail
    fill_in "Impression", with: @stress_record.impression
    fill_in "Stress relief date", with: @stress_record.stress_relief_date
    fill_in "Title", with: @stress_record.title
    fill_in "User", with: @stress_record.user_id
    click_on "Create Stress record"

    assert_text "Stress record was successfully created"
    click_on "Back"
  end

  test "should update Stress record" do
    visit stress_record_url(@stress_record)
    click_on "Edit this stress record", match: :first

    fill_in "After stress level", with: @stress_record.after_stress_level
    fill_in "Before stress level", with: @stress_record.before_stress_level
    fill_in "Detail", with: @stress_record.detail
    fill_in "Impression", with: @stress_record.impression
    fill_in "Stress relief date", with: @stress_record.stress_relief_date
    fill_in "Title", with: @stress_record.title
    fill_in "User", with: @stress_record.user_id
    click_on "Update Stress record"

    assert_text "Stress record was successfully updated"
    click_on "Back"
  end

  test "should destroy Stress record" do
    visit stress_record_url(@stress_record)
    click_on "Destroy this stress record", match: :first

    assert_text "Stress record was successfully destroyed"
  end
end
