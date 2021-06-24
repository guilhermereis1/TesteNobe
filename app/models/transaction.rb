# == Schema Information
#
# Table name: transactions
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  kind       :integer          not null
#  value      :decimal(, )      not null
#  account_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Transaction < ApplicationRecord
  belongs_to :account

  enum kind: { money_deposit: 0, outgoing_money: 1 }
end
