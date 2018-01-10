class User < ApplicationRecord  
  has_many :cards, dependent: :destroy
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: lambda {
    new_record? || changes[:crypted_password] 
  }
  validates :password, confirmation: true, if: lambda {
    new_record? || changes[:crypted_password] 
  }
  validates :password_confirmation, presence: true, if: lambda {
    new_record? || changes[:crypted_password] 
  }

  validates :email, uniqueness: true
end
