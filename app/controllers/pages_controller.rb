class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :show ]

  def home
  end

  def profil
    @races = Race.count { |race| race.status == "done"}
  end
end
