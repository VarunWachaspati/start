class MessagesController < ApplicationController
  before_action :signed_in_user
  #before_action :correct_user
 
  def new
  end
 
  def create
    recipients = Entrepreneur.where(id: params['recipients']) || Mentor.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end
end