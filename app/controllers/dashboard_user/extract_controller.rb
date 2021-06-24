class DashboardUser::ExtractController < ApplicationController
  before_action :authenticate_user!
  layout 'user'
  
  def index
    date_start = params[:date_start]
    date_end = params[:date_end]

    if date_start.present? && date_end.present? then
      @trx = Transaction.where(account_id: @account.id).where('created_at BETWEEN ? AND ?', date_start, date_end)
    elsif date_start.present?
      @trx = Transaction.where(account_id: @account.id).where("created_at >= ?", date_start)
    elsif date_end.present?
      @trx = Transaction.where(account_id: @account.id).where("created_at <= ?", date_end)
    else
      @trx = []
    end
  end
end
