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

  test "should create correct event with json" do
    post spam_url, params: {"_json"=>[{"email"=>"a@b.com", "smtp-id"=>"<32eafb51-b35a-410b-a8cb-834ba896c563@less.works>", "timestamp"=>1484881350, "sg_event_id"=>"c6aq-1VBSS27Je8rMbSuCA", "sg_message_id"=>"filter0148p1las1-7202-58817DC6-9.0", "reason"=>"Bounced Address", "event"=>"dropped"}], "event"=>{"_json"=>[{"email"=>"a@b.com", "smtp-id"=>"<32eafb51-b35a-410b-a8cb-834ba896c563@less.works>", "timestamp"=>1484881350, "sg_event_id"=>"c6aq-1VBSS27Je8rMbSuCA", "sg_message_id"=>"filter0148p1las1-7202-58817DC6-9.0", "reason"=>"Bounced Address", "event"=>"dropped"}]}}
    assert_equal @event[:email], 'a@b.com'
  end

end
