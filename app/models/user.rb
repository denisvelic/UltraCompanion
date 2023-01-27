class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: [:google_oauth2]
          # authentification google

          # def self.from_google(auth)
          #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          #     user.email = auth.info.email
          #     user.password = Devise.friendly_token[0, 20]
          #   end
          # end

          # def self.from_google(auth)
          #   # This line checks if the user email received by the Omniauth is already included in our databases.
          #     user = User.where(email: auth.info.email).first
          #   # This line sets the user unless there is a user found in the line above, therefore we use ||= notation to evaluate if the user is nill, then set it to the User.create
          #     user ||= User.create!(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20])
          #     user
          #   end

  has_many :races
  has_one_attached :photo
end
