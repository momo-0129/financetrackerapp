class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present? 
      @friend = params[:friend]
      if @friend  
        respond_to do |format|
          format.turbo_stream {
            render turbo_stream: turbo_stream.update("friendslist", partial: "users/friend_result")
          }
        end
      else  
        respond_to do |format|
          format.turbo_stream {
            flash.now[:alert] = "Couldn't find user"
            render turbo_stream: turbo_stream.update("friendslist", partial: "layouts/messages")            
          }
        end
      end
    else
      respond_to do |format| 
        format.turbo_stream {
          flash.now[:alert] = "Can not be empty"
          render turbo_stream: turbo_stream.update("friendslist", partial: "layouts/messages")
        }
      end
    end
  end
end
