class StocksController < ApplicationController
  def search
    if params[:stock].present? 
      @stock = Stock.new_lookup(params[:stock])
      if @stock  
        respond_to do |format|
          format.turbo_stream {
            render turbo_stream: turbo_stream.append("test", partial: "users/result")
          }
        end
      else  
        flash[:alert] = "Please enter a valid symbol to search"
        redirect_to my_portfolio_path
      end
    else
      # do something different
      flash[:alert] = "can not be empty"
      redirect_to my_portfolio_path 
    end   
  end
end