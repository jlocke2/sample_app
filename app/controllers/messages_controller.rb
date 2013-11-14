class MessagesController < ApplicationController
	before_action :signed_in_user, only: [:index, :inbox, :outbox, :create, :show]
	before_action :correct_user,   only: [:index, :inbox, :outbox]

	def index
		@messages = current_user.inbox.paginate(page: params[:page], :per_page => 10)

	end

	def inbox
	 @ide = User.from_param(params[:id]).id
     
	  @messages = current_user.inbox.paginate(page: params[:page], :per_page => 10)
    #   @sender = User.find(message.sender_id).user_name
	end

	def outbox
			#  ide = User.from_param(params[:id]).id

	@messages = current_user.outbox.paginate(page: params[:page], :per_page => 10)

		
	end

	def create
      @user = User.find(params[:message][:receiver_id])
      @message = current_user.messages.build(message_params)
      if @message.save
      	redirect_to @user
      else
      redirect_to root_url
  end
	end

	def show
		redirect_to inbox_message_path
		
	end

  private

  def message_params
  	params.require(:message).permit(:content, :sender_id, :receiver_id)
  end

  def correct_user
      @user = User.find_by(user_name: params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end