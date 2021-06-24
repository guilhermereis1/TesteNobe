class DashboardUser::HomeController < ApplicationController
  before_action :authenticate_user!
  layout 'user'
  
  def index
    @transactions = Transaction.where(account_id: @account.id).order(created_at: :desc).limit(5)
  end
end
