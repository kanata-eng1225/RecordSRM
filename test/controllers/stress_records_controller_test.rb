require "test_helper"

class StressRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stress_record = stress_records(:one)
  end

  test "should get index" do
    get stress_records_url
    assert_response :success
  end

  test "should get new" do
    get new_stress_record_url
    assert_response :success
  end

  test "should create stress_record" do
    assert_difference("StressRecord.count") do
      post stress_records_url, params: { stress_record: { after_stress_level: @stress_record.after_stress_level, before_stress_level: @stress_record.before_stress_level, detail: @stress_record.detail, impression: @stress_record.impression, stress_relief_date: @stress_record.stress_relief_date, title: @stress_record.title, user_id: @stress_record.user_id } }
    end

    assert_redirected_to stress_record_url(StressRecord.last)
  end

  test "should show stress_record" do
    get stress_record_url(@stress_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_stress_record_url(@stress_record)
    assert_response :success
  end

  test "should update stress_record" do
    patch stress_record_url(@stress_record), params: { stress_record: { after_stress_level: @stress_record.after_stress_level, before_stress_level: @stress_record.before_stress_level, detail: @stress_record.detail, impression: @stress_record.impression, stress_relief_date: @stress_record.stress_relief_date, title: @stress_record.title, user_id: @stress_record.user_id } }
    assert_redirected_to stress_record_url(@stress_record)
  end

  test "should destroy stress_record" do
    assert_difference("StressRecord.count", -1) do
      delete stress_record_url(@stress_record)
    end

    assert_redirected_to stress_records_url
  end
end
