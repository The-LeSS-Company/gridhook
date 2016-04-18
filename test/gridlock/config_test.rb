require 'helper'

class ConfigTest < TestCase
  def setup
    @config = Gridhook.config
  end

  test 'configure block' do
    Gridhook.configure do |config|
      config.event_processor = proc { }
    end
    assert_kind_of Proc, @config.event_processor
  end

end
