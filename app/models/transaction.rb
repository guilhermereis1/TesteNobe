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

  with_options presence: true do
    validates :kind
    validates :value
  end

  validate :non_zero

  protected

  def non_zero
    if self.value == 0 then
      self.errors.add(:value, "deve ser diferente e maior de 0!")
    end
  end
end