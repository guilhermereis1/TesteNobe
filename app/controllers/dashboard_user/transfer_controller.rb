class DashboardUser::TransferController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :authenticate_user!
  layout 'user'
  
  def index
    cpf_or_cnpj = params[:cpf_or_cnpj]
    
    @data = { error: false, message: "" }

    if cpf_or_cnpj.present? then
      user = User.find_by(cpf_or_cnpj: cpf_or_cnpj)

      if user.present? then
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

    if value.present? != 0.0 && user.present? then
      if value > @account.balance then
        respond_to do |format|
          format.html { redirect_to dashboard_user_transfer_index_path, notice: "Você não pode Transfêrir um valor maior que o da sua Conta!" }
        end
      else
        # Current user
        Transaction.create!(
          name: "Transferência de: #{number_to_currency(value, :unit => "R$ ", :separator => ",", :delimiter => ".")} para #{user.name} - #{user.cpf_or_cnpj}",
          value: value,
          kind: 2,
          account_id: @account.id
        )

        @account.update(balance: @account.balance - value)

        # To user
        Transaction.create!(
          name: "Transferência recebida de: #{@account.user.name} - #{@account.user.cpf_or_cnpj}, no valor:  #{number_to_currency(value, :unit => "R$ ", :separator => ",", :delimiter => ".")}",
          value: value,
          kind: 2,
          account_id: receiver.id
        )
        receiver.update(
          balance: receiver.balance + value
        )
      end
    end
    
    redirect_to dashboard_user_transfer_index_path
  end
end
# 34191499000183