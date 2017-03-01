class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_one :shipping_address, -> { where addressable_type: "shipping_address"},
     class_name: Address, foreign_key: :addressable_id, foreign_type: :addressable_type, dependent: :destroy
  has_one :billing_address, -> { where addressable_type: "billing_address"},
     class_name: Address, foreign_key: :addressable_id, foreign_type: :addressable_type, dependent: :destroy

end
