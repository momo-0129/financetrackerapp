class StocksController < ApplicationController
  def search
    if params[:stock].present? 
      @stock = Stock.new_lookup(params[:stock])
      if @stock  
        respond_to do |format|
          format.turbo_stream {
            render turbo_stream: turbo_stream.update("test", partial: "users/result")
          }
        end
      else  
        respond_to do |format|
          format.turbo_stream {
            flash.now[:alert] = "Please enter a valid symbol to search"
            render turbo_stream: turbo_stream.update("test", partial: "users/result")            
          }
        end
      end
    else
      respond_to do |format| 
        format.turbo_stream {
          flash.now[:alert] = "Can not be empty"
          render turbo_stream: turbo_stream.update("test", partial: "users/result")
        }
      end
    end   
  end
end