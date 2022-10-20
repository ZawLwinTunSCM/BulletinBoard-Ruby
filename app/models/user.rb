class User < ApplicationRecord

    has_secure_password

    has_one_attached :profile

    before_save :email.downcase

    validates :name, presence: { message: " cannot be empty!" }, length: { minimum: 3, maximum: 100}
    validates :email, presence: { message: " cannot be empty!" }, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/}
    validates :password, confirmation: true, presence: { message: " cannot be empty!" },length: { minimum: 3} , on: :create
    validates :phone, numericality: { message: " must be number!" }, presence: { message: " cannot be empty!" }, length: { is: 11 }
    validates :address, length: {maximum: 150}
    validates_inclusion_of :admin_flg,presence: { message: " must be choosen!" }, :in => [true, false]

end
