require "test_helper"

class StressReliefsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stress_relief = stress_reliefs(:one)
  end

  test "should get index" do
    get stress_reliefs_url
    assert_response :success
  end

  test "should get new" do
    get new_stress_relief_url
    assert_response :success
  end

  test "should create stress_relief" do
    assert_difference("StressRelief.count") do
      post stress_reliefs_url, params: { stress_relief: { detail: @stress_relief.detail, difficulty: @stress_relief.difficulty, title: @stress_relief.title, user_id: @stress_relief.user_id } }
    end

    assert_redirected_to stress_relief_url(StressRelief.last)
  end

  test "should show stress_relief" do
    get stress_relief_url(@stress_relief)
    assert_response :success
  end

  test "should get edit" do
    get edit_stress_relief_url(@stress_relief)
    assert_response :success
  end

  test "should update stress_relief" do
    patch stress_relief_url(@stress_relief), params: { stress_relief: { detail: @stress_relief.detail, difficulty: @stress_relief.difficulty, title: @stress_relief.title, user_id: @stress_relief.user_id } }
    assert_redirected_to stress_relief_url(@stress_relief)
  end

  test "should destroy stress_relief" do
    assert_difference("StressRelief.count", -1) do
      delete stress_relief_url(@stress_relief)
    end

    assert_redirected_to stress_reliefs_url
  end
end
