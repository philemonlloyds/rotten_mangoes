class Admin::UsersController < ApplicationController
  before_filter :authorize_admin

  def index
    @user = User.all.page(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  protected
  

end
