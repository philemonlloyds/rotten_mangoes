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


end
