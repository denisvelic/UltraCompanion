class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: [:google_oauth2]
          # authentification google & strava

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
# Authentification google

# def self.from_omniauth(auth)
#   # Crée ou récupère l'utilisateur qui s'est connecté via Omniauth-Strava
#   user = User.find_or_create_by(strava_id: auth.uid)
#   user.name = auth.info.name
#   user.access_token = auth.credentials.token
#   user.save!
#   user
# end

  has_many :races
  has_one_attached :photo
end
