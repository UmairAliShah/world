class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  acts_as_token_authenticatable

  #scope :find_user_by_email, ->(email) { find_by(:email => email) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
