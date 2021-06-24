require 'rails_helper'

RSpec.describe Account, :type => :model do
  context "Validate Account" do

    it "Create an account with a User" do
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
      
      expect(user).to be_valid
      expect(account).to be_valid
    end

    it "Create an account without a user" do
      account = Account.new(user_id: nil, balance: 0.0)
      account.save
      expect(account).to_not be_valid
    end

  end
end