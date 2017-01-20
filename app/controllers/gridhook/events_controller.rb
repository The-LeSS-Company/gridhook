module Gridhook
  class EventsController < ActionController::Base
    def create
      Gridhook::Event.process(event_params)
      head :ok
    end

    def spam_message
      Gridhook::SpamMessage.process(event_params)
      head :ok
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.permit(:email, :event, :reason, :status, :_json => [:email, :event, :reason, :status])
    end
  end
end
