class Admin::UsersController < ApplicationController
  before_filter :authorize_admin

  def index
    @users = User.all.page(params[:id])
    @movies = Movie.all.page(params[:title])
    @reviews = Review.all.page(params[:user_id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "New User, #{@user.firstname} created!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: "User edit for, #{@user.firstname} has been completed!"
    else
      render :edit
    end
  end

  protected
  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation,:admin)
  end

end
