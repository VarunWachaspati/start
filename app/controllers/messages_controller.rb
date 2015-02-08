class MessagesController < ApplicationController
  before_action :signed_in_user
  #before_action :correct_user
 
  def new
  	@mentor=Mentor.find(params[:id])
  	recipients_options(@mentor)
  	#@messages= current_user.
  end
 
  def create
  	@rec = Mentor.find(params[:id])
    recipients = Mentor.where(id: params['recipients'])
    conversation = current_user.send_message(@rec, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end
end