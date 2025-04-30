# app/models/user.rb
class User < ApplicationRecord
  has_many :expenses, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

# app/models/expense.rb
class Expense < ApplicationRecord
  belongs_to :user
  validates :name, :amount, :date, presence: true
  validates :amount, numericality: { greater_than: 0 }
end