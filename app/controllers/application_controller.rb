class ApplicationController < ActionController::Base
  # before_action :authenticate_user!

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
  # deconnecter User
end
