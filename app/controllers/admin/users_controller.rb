# app/controllers/admin/users_controller.rb
class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
  
    def show
      @user = User.find(params[:id])
      @expenses = @user.expenses.order(date: :desc)
    end
  
    private
  
    def check_admin
      unless current_user.admin?
        redirect_to root_path, alert: "Not authorized"
      end
    end
  end