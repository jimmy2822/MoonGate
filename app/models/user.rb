class User < ApplicationRecord
  has_many :gates
  has_many :like_logs, foreign_key:"who_liked"
  # Devise setting
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
