class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end

  def my_friends
    @friendships = current_user.friends
  end

  def search
    if params[:search_param].blank?
      flash.now[:danger] = 'Please enter name or e-mail address.'
    else
      @users = User.search(params[:search_param], current_user)

      flash.now[:danger] = 'No users found.' if @users.blank?
    end

    respond_to do |format|
      format.js { render partial: 'friends/result' }
    end
  end

  def add_friend
    friend = User.find(params[:friend])

    if current_user.friends << friend
      flash[:success] = 'Friend was successfully added.'
    else
      flash[:danger] = 'Something happened and it was not good.'
    end

    redirect_to my_friends_path
  end

  def show
    @user = User.find(params[:id])
    @user_stocks = @user.stocks
  end
end
