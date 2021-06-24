# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  cpf_or_cnpj            :string           not null
#  name                   :string           not null
#  status                 :integer          default("opened"), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
