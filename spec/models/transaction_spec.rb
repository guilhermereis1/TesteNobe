require 'rails_helper'

RSpec.describe Transaction, :type => :model do
  context "Validate Transaction" do

    it "Create a valid Deposit Transaction!" do
      user = User.new(
        name: 'Guilherme Reis',
        email: 'gui@gmail.com',
        cpf_or_cnpj: '35957566063',
        password: '123123',
        password_confirmation: '123123'
      )
      user.save

      account = Account.new(user_id: user.id, balance: 0.0)
      account.save

      value = 150.0
      description = "Depósito no valor de: #{value}"

      transaction = Transaction.new(
        name: description,
        kind: 0,
        value: value,
        account_id: account.id
      )

      transaction.save
      
      expect(user).to be_valid
      expect(account).to be_valid
      expect(transaction).to be_valid
    end

    it "Create a valid Cash Out transaction!" do
      user = User.new(
        name: 'Guilherme Reis',
        email: 'gui@gmail.com',
        cpf_or_cnpj: '35957566063',
        password: '123123',
        password_confirmation: '123123'
      )
      user.save

      account = Account.new(user_id: user.id, balance: 0.0)
      account.save

      value = 200.0
      description = "Saque no valor de: #{value}"

      transaction = Transaction.new(
        name: description,
        kind: 1,
        value: value,
        account_id: account.id
      )

      transaction.save
      
      expect(user).to be_valid
      expect(account).to be_valid
      expect(transaction).to be_valid
    end

    it "Create a Transfer Transaction" do
      user_one = User.new(
        name: 'Guilherme Reis',
        email: 'gui@gmail.com',
        cpf_or_cnpj: '35957566063',
        password: '123123',
        password_confirmation: '123123'
      )

      user_two = User.new(
        name: 'Teste Usuário',
        email: 'teste@gmail.com',
        cpf_or_cnpj: '58685774000183',
        password: '123123',
        password_confirmation: '123123'
      )

      user_one.save
      user_two.save

      account_one = Account.new(user_id: user_one.id, balance: 100.0)
      account_two = Account.new(user_id: user_two.id, balance: 100.0)

      account_one.save
      account_two.save

      value = 100.0
      description = "Transferência de #{value} para #{user_two.name} - #{user_two.cpf_or_cnpj}"

      transaction_one = Transaction.new(
        name: description,
        kind: 1,
        value: value,
        account_id: account_one.id
      )

      account_one.update(
        balance: account_one.balance - value
      )

      account_one.save

      transaction_two = Transaction.new(
        name: description,
        kind: 1,
        value: value,
        account_id: account_two.id
      )

      account_two.update(
        balance: account_one.balance + value
      )

      account_two.save
      transaction_one.save
      transaction_two.save
      
      expect(user_one).to be_valid
      expect(user_two).to be_valid

      expect(account_one).to be_valid
      expect(account_two).to be_valid
      
      expect(transaction_one).to be_valid
      expect(transaction_two).to be_valid
    end
  end
end