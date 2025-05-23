require "test_helper"

class SchoolEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @school_event = school_events(:one)
  end

  test "should get index" do
    get school_events_url
    assert_response :success
  end

  test "should get show" do
    get school_event_url(@school_event)
    assert_response :success
  end

  test "should get new" do
    get new_school_event_url
    assert_response :success
  end

  test "should get edit" do
    get edit_school_event_url(@school_event)
    assert_response :success
  end

  test "should create school_event" do
    assert_difference('SchoolEvent.count') do
      post school_events_url, params: { school_event: { title: 'テストイベント', start_date: Date.tomorrow, end_date: 2.days.from_now, description: 'テスト用イベント' } }
    end
    assert_redirected_to school_event_url(SchoolEvent.last)
  end

  test "should update school_event" do
    patch school_event_url(@school_event), params: { school_event: { title: '更新イベント' } }
    assert_redirected_to school_event_url(@school_event)
    @school_event.reload
    assert_equal '更新イベント', @school_event.title
  end

  test "should destroy school_event" do
    assert_difference('SchoolEvent.count', -1) do
      delete school_event_url(@school_event)
    end
    assert_redirected_to school_events_url
  end
end
