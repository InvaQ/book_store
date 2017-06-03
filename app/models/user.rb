class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook] #, :confirmable
  has_many :orders, dependent: :destroy
  
  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_one :billing_address, as: :addressable, dependent: :destroy
  validates :email, :password, presence: true
  validates :email, format: {with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/iu }
  #validates :password, format: {with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}\z/}
  #has_one :avatar, as: :imageable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      name = auth.info.name.split(' ')
      user.create_billing_address(first_name: name[0],last_name: name[1])
      user.create_shipping_address(first_name: name[0],last_name: name[1])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


  def self.fast_registration(sign_up_params)
    user = new sign_up_params
    user.provider = 'fast'
    user.password = Devise.friendly_token[0,20]
    binding.pry
    ApplicationMailer.send_password(user.email, user.password).deliver_now if user.save
    user
  end


end
