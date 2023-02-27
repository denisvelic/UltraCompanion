class Strava::OauthsController < ApplicationController
  def connect
    client = Strava::OAuth::Client.new(
      client_id: ENV['STRAVA_CLIENT_ID'],
      client_secret: ENV['STRAVA_CLIENT_SECRET']
    )

    redirect_url = client.authorize_url(
      redirect_uri: complete_connection_strava_oauth_redirect_url,
      approval_prompt: 'force',
      response_type: 'code',
      scope: 'activity:read_all',
      state: 'magic'
    )

    redirect_to redirect_url
  end
