class TransactionsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  layout 'user'
  
  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.where(account_id: @account.id).order(created_at: :desc)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new() 

    kind = transaction_params[:kind].to_i
    value = transaction_params[:value].to_d

      if kind == 0 then
        create_transaction(@transaction, value, kind)

        respond_to do |format|
          if @transaction.save
            format.html { redirect_to @transaction, notice: "Transação criada com sucesso!" }
            format.json { render :show, status: :created, location: @transaction }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @transaction.errors, status: :unprocessable_entity }
          end
        end
      elsif kind == 1 then

        if value > @account.balance then
          respond_to do |format|
            format.html { redirect_to new_transaction_path, notice: "Ooppss... Você não pode Sacar um valor maior que o da sua Conta!" }
          end
        else
          create_transaction(@transaction, transaction_params[:value].to_d, transaction_params[:kind].to_i)

          respond_to do |format|
          if @transaction.save
            format.html { redirect_to @transaction, notice: "Transação criada com sucesso!" }
            format.json { render :show, status: :created, location: @transaction }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @transaction.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transação deletada com sucesso!" }
      format.json { head :no_content }
    end
  end

  private
    def update_balance(value)
      @account.update(balance: value)
    end

    def create_transaction(trx, value, kind)
      trx.account_id = @account.id
      trx.kind = kind

      if kind == 0 then
        trx.name = "Depósito no valor de: #{number_to_currency(value, :unit => "R$ ", :separator => ",", :delimiter => ".")}"
        update_balance(@account.balance + value)
      elsif kind == 1 then
        trx.name = "Saque no valor de: #{number_to_currency(value, :unit => "R$ ", :separator => ",", :delimiter => ".")}"
        update_balance(@account.balance - value)
      end

      trx.value = value
      trx
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:kind, :value)
    end
end
