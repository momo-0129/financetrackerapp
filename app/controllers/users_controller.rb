class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    if params[:friend].present? 
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends  
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
          flash.now[:alert] = "Input can not be empty"
          render turbo_stream: turbo_stream.update("friendslist", partial: "layouts/messages")
        }
      end
    end
  end
end
