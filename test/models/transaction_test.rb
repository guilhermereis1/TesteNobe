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
require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
