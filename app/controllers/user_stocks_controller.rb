class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was add to your account"
    redirect_to my_portfolio_path

    # respond_to do |format|
    #   format.turbo_stream {
    #     flash.now[:notice] = "Stock #{stock.name} was add to your account"
    #     render turbo_stream: turbo_stream.append("list", partial: "stocks/list", locals: {tracked_stocks: @tracked_stocks, current_user: current_user})
    #   }
    # end
  end
end
 