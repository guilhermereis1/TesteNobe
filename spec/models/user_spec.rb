require 'rails_helper'

RSpec.describe User, :type => :model do
  context "Validate User" do

    it "Valid User" do
      user = User.new(
        name: 'Guilherme Reis',
        email: 'teste@gmail.com',
        cpf_or_cnpj: '35957566063',
        password: '123123',
        password_confirmation: '123123'
      )
      user.save
      
      expect(user).to be_valid 
    end

    it "Not Valid User" do
      user = User.new(
        name: '',
        email: '',
        cpf_or_cnpj: '',
        password: '',
        password_confirmation: ''
      )
      user.save

      expect(user).to_not be_valid 
    end

    it "When creating user, creates an account automatically" do
      user = User.new(
        name: 'Guilherme Reis',
        email: 'teste@gmail.com',
        cpf_or_cnpj: '35957566063',
        password: '123123',
        password_confirmation: '123123'
      )
      user.save

      account = Account.new(user_id: user.id, balance: 0.0)

      account.save

      expect(user).to be_valid
      expect(account).to be_valid
    end

  end
end