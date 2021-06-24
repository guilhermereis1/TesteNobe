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
    kind = transaction_params[:kind].to_i
    value = transaction_params[:value].to_i

    if kind == 0 then
      trx = create_transaction("Depósito no valor de: #{number_to_currency(value, :unit => "R$ ", :separator => ",", :delimiter => ".")}", 0, value)
      @account.update(balance: @account.balance + value)

      respond_to do |format|
        format.html { redirect_to transaction_path(trx.id), notice: "Transação realizada com sucesso!" }
        format.json { render :show, status: :created, location: @transaction }
      end
    elsif kind == 1 then
      if value > @account.balance then
        respond_to do |format|
          format.html { redirect_to new_transaction_path, notice: "Você não pode Sacar um valor maior que o da sua Conta!" }
        end
      else
        trx = create_transaction("Saque no valor de: #{number_to_currency(value, :unit => "R$ ", :separator => ",", :delimiter => ".")}", 0, value)
        @account.update(balance: @account.balance - value)
        respond_to do |format|
          format.html { redirect_to transaction_path(trx.id), notice: "Transação realizada com sucesso!" }
          format.json { render :show, status: :created, location: @transaction }
        end
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: "Transação atualizada com sucesso!" }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
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
    def create_transaction(name, kind, value)
      Transaction.create!(
        name: name,
        kind: kind,
        value: value,
        account_id: @account.id
      )
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
