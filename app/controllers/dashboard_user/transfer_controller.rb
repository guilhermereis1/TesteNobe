class DashboardUser::TransferController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :authenticate_user!
  layout 'user'
  
  def index
    cpf_or_cnpj = params[:cpf_or_cnpj]
    @data = { error: false, message: "" }

    if cpf_or_cnpj.present? then
      user = User.find_by(cpf_or_cnpj: cpf_or_cnpj)

      if user.present? && user.id.to_i != current_user.id.to_i then
        @user = user
      else
        @user = nil
        @data = {
          error: true,
          message: "Usuário não existe!"
        }
      end
    else
      @user = nil
    end
  end

  def make_transfer
    value = params[:value].to_d
    user = User.find(params[:user_id].to_i)
    receiver = Account.find_by(user_id: user.id)
    tax = verify_date(Date.today.strftime('%A'), value)

    if value.present? != 0.0 && user.present? && user.id.to_i != current_user.id.to_i then
      if (value.to_d + tax) > @account.balance then
        respond_to do |format|
          format.html { redirect_to dashboard_user_transfer_index_path, notice: "Você não possui Saldo suficiente para estra Transferência!" }
        end
      else
        # Current User
        create_transaction("Transferência de: #{real(value)} para #{user.name} - #{user.cpf_or_cnpj}", value, tax, nil)
        
        # To User
        create_transaction("Transferência recebida de: #{@account.user.name} - #{@account.user.cpf_or_cnpj}, no valor:  #{real(value)}", value, tax, receiver)

        respond_to do |format|
          format.html { redirect_to dashboard_user_transfer_index_path, notice: "Transferência feita com sucesso!" }
        end
      end
    end
  end

  private

  def create_transaction(name, value, tax, receiver)
    if receiver == nil then
      Transaction.create!(name: name, value: value, kind: 2, account_id: @account.id, tax: tax)
      @account.update(balance: (@account.balance - (tax_above_thousand(value) + tax)))
    else
      Transaction.create!(name: name, value: value, kind: 2, account_id: receiver.id, tax: 0.0)
      receiver.update(balance: receiver.balance + value)
    end
  end

  def verify_date(date, value)
    @tax = 0.0
    case date
    when 'Monday'
      tax(@tax, value)
    when 'Tuesday'
      tax(@tax, value)
    when 'Wednesday'
      tax(@tax, value)
    when 'Thursday'
      tax(@tax, value)
    when "Friday"
      tax(@tax, value)
    else
      nil
    end
  end

  def tax(tax, value)
    if value >= 1000.0 then
      tax_hour ? 15.0 : 17.0
    elsif value < 1000.0
      tax_hour ? 5.0 : 7.0
    end
  end

  def tax_above_thousand(value)
    if value >= 1000.0 then
      value + 10.0
    else
      value
    end
  end

  def tax_hour(start_hour = '09:00', end_hour = '18:00')
    DateTime.now.to_s(:time) >= start_hour && DateTime.now.to_s(:time) <= end_hour
  end

  def real(value)
    number_to_currency(value, :unit => "R$ ", :separator => ",", :delimiter => ".")
  end
end