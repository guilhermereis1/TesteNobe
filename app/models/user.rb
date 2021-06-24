# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  cpf_or_cnpj            :string           not null
#  name                   :string           not null
#  status                 :integer          default(0), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_one :account

  with_options presence: true do
    validates :name
    validates :cpf_or_cnpj, uniqueness: true
    validates :email, uniqueness: true
    validates :password
    validates :password_confirmation
  end

  enum status: { opened: 0, closed: 1 }

  after_save :valid_document
  after_create :create_account

  private
  
  # Cria uma Account quando o Usuário faz o cadastro
  def create_account
    Account.create!(user_id: self.id, balance: 0.0)
  end

  # Valida se o Documento CPF ou CNPJ é válido
  def valid_document
    if !CPF.valid?(self.cpf_or_cnpj) && !CNPJ.valid?(self.cpf_or_cnpj) then
      errors.add(:cpf_or_cnpj, "Insira um Documento Válido!")
      raise ActiveRecord::Rollback
    end
  end
end
