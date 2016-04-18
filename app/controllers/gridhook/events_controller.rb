module Gridhook
  class EventsController < ActionController::Base
    def create
      Gridhook::Event.process(params)
      head :ok
    end

    def spam_message
      Gridhook::SpamMessage.process(params)
      head :ok
    end
  end
end
