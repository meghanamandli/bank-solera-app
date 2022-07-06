class UsersController < ApplicationController

def new
  @user = User.new
end

def create
	@user = User.new(user_params)
	if @user.save
		session[:user_id] = @user.user_id
	    redirect_to root_path
	else
		render :new
	end
end

    def show
    	@user = User.find(params[:id])
    end

    private

    def user_params
    	params.require(:user).permit(:username, :password)
    end

    def transfer_amount
    @recipient_account = Account.find_by_id(params[:account_id])
    @user = User.find_by_id(params[:user_id])
    @user_account = Account.find_by_id(@user.id)
    @amount = params[:amount]
    if params[:amount] < @user_account.balance
    	@recipient_account.balance = @account.balance + @amount
    	@recipient_account.save
    else
    message = "Balance is not sufficient to perform this transaction "
	redirect_to referrer, notice: message
    end
end