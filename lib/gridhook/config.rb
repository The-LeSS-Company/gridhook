module Gridhook

  # Returns a new Config instance.
  def self.config
    @config ||= Config.new
  end

  # A helper method for providing a configure block.
  def self.configure
    yield config
  end

  # This class handles storing Gridhooks configuration variables.
  class Config < Struct.new(:event_processor, :spam_message_processor, :event_receive_path, :spam_message_path)
  end

end
