# class SessionsController < ApplicationController
#   def create
#     auth = request.env["omniauth.auth"]
#     user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
#     session[:user_id] = user.id
#     redirect_to root_url, notice: "Connecté avec succès avec Strava."
#   end

#   def destroy
#     session[:user_id] = nil
#     redirect_to root_url, notice: "Déconnecté avec succès."
#   end
# end
# controller pour auth avec strava

# class AuthController < ApplicationController
#   # def create
#   #   auth = request.env["omniauth.auth"]
#   #   user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
#   #   session[:user_id] = user.id
#   #   redirect_to root_url, notice: "Connecté avec succès avec Strava."
#   # end

#   # def destroy
#   #   session[:user_id] = nil
#   #   redirect_to root_url, notice: "Déconnecté avec succès."
#   # end

#   def strava
#     auth_hash = request.env['omniauth.auth']
#     # Récupération des informations d'authentification de Strava depuis auth_hash
#     auth_token = auth_hash['credentials']['token']
#     # Utilisation de l'API Strava pour récupérer les informations de l'utilisateur
#     strava_client = Strava::Api::V3::Client.new(access_token: auth_token)
#     athlete_info = strava_client.retrieve_current_athlete
#     # Création ou mise à jour de l'utilisateur dans la base de données de votre application
#     user = User.find_or_create_by(strava_id: athlete_info['id']) do |u|
#       u.name = athlete_info['firstname'] + ' ' + athlete_info['lastname']
#       u.access_token = auth_token
#     end
#     # Connexion de l'utilisateur dans votre application
#     session[:user_id] = user.id
#     redirect_to root_path, notice: "Vous êtes connecté avec succès avec Strava !"
#   end

# end
