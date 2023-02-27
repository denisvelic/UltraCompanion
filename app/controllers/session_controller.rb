class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, notice: "Connecté avec succès avec Strava."
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Déconnecté avec succès."
  end
end
# controller pour auth avec strava
