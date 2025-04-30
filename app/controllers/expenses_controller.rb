# app/controllers/expenses_controller.rb
class ExpensesController < ApplicationController
    before_action :authenticate_user!
    
    def index
      if current_user.admin?
        @users = User.where.not(id: current_user.id) # Exclude admin from user list
        # Don't load admin's expenses in the @expenses variable
      else
        @expenses = current_user.expenses.order(date: :desc)
      end
    end
    
    def new
      @expense = current_user.expenses.new
    end
    
    def create
      @expense = current_user.expenses.new(expense_params)
      if @expense.save
        redirect_to expenses_path, notice: "Expense was successfully created."
      else
        render :new
      end
    end
    
    private
    
    def expense_params
      params.require(:expense).permit(:name, :amount, :date)
    end
  end
  
  # app/controllers/admin/users_controller.rb
  class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
    
    def index
      @users = User.all
    end
    
    def show
      @user = User.find(params[:id])
      @expenses = @user.expenses.order(date: :desc)
    end
    
    private
    
    def check_admin
      unless current_user.admin?
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
  end