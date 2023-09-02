require "application_system_test_case"

class StressReliefsTest < ApplicationSystemTestCase
  setup do
    @stress_relief = stress_reliefs(:one)
  end

  test "visiting the index" do
    visit stress_reliefs_url
    assert_selector "h1", text: "Stress reliefs"
  end

  test "should create stress relief" do
    visit stress_reliefs_url
    click_on "New stress relief"

    fill_in "Detail", with: @stress_relief.detail
    fill_in "Difficulty", with: @stress_relief.difficulty
    fill_in "Title", with: @stress_relief.title
    fill_in "User", with: @stress_relief.user_id
    click_on "Create Stress relief"

    assert_text "Stress relief was successfully created"
    click_on "Back"
  end

  test "should update Stress relief" do
    visit stress_relief_url(@stress_relief)
    click_on "Edit this stress relief", match: :first

    fill_in "Detail", with: @stress_relief.detail
    fill_in "Difficulty", with: @stress_relief.difficulty
    fill_in "Title", with: @stress_relief.title
    fill_in "User", with: @stress_relief.user_id
    click_on "Update Stress relief"

    assert_text "Stress relief was successfully updated"
    click_on "Back"
  end

  test "should destroy Stress relief" do
    visit stress_relief_url(@stress_relief)
    click_on "Destroy this stress relief", match: :first

    assert_text "Stress relief was successfully destroyed"
  end
end
