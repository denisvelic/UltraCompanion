class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # def google_oauth2
  #   user = User.from_omniauth(auth)
  #   if user.present?
  #     sign_out_all_scopes
  #     flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
  #     sign_in_and_redirect user, event: :authentication
  #   else
  #     flash[:alert] =
  #       t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
  #     redirect_to new_user_session_path
  #   end

  #   auth = request.env['omniauth.auth']
  #   email = auth.info.email
  #   # récupérer emails
  # end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_session_path
    end

    auth = request.env['omniauth.auth']
    email = auth.info.email
  # récupérer emails
  end

  # def strava
  #   auth_hash = request.env['omniauth.auth']
  #   # Récupération des informations d'authentification de Strava depuis auth_hash
  #   auth_token = auth_hash['credentials']['token']
  #   # Utilisation de l'API Strava pour récupérer les informations de l'utilisateur
  #   strava_client = Strava::Api::V3::Client.new(access_token: auth_token)
  #   athlete_info = strava_client.retrieve_current_athlete
  #   # Création ou mise à jour de l'utilisateur dans la base de données de votre application
  #   user = User.find_or_create_by(strava_id: athlete_info['id']) do |u|
  #     u.name = athlete_info['firstname'] + ' ' + athlete_info['lastname']
  #     u.access_token = auth_token
  #   end
  #   # Connexion de l'utilisateur dans votre application
  #   sign_in_and_redirect user, event: :authentication
  # end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  private

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end

# authentification
