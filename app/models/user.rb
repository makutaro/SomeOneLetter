class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # valid_name
  validates :name,  presence: true, length: { in: 4..20  },
                    uniqueness: { case_sensitive: false } #重複を認めない

  # valid_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  #valid_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
