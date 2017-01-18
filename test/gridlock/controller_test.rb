require 'helper'


class ControllerTest < ActionDispatch::IntegrationTest
  def event_processor(event)
    @event = event
  end

  setup do
    @saved_processor = Gridhook.config.event_processor
    Gridhook.config.event_processor = method(:event_processor)
  end

  teardown do
    Gridhook.config.event_processor = @saved_processor
  end

  test "should return success response code" do
    post spam_url, params: {}
    assert_response :success
    assert @event.present?
  end

  test "should create correcgt event" do
    post spam_url, params: {email: 't@m.com', event: 'a'}
    assert_equal @event[:email], 't@m.com'
    assert_equal @event[:event], 'a'
  end
end
