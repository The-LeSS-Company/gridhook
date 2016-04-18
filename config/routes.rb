Rails.application.routes.draw do
  post Gridhook.config.event_receive_path => 'gridhook/events#create'
  post Gridhook.config.spam_message_path => 'gridhook/events#spam_message'
end
