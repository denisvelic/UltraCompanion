class FeedbackMailer < ApplicationMailer
  def feedback_email
    @feedback = params[:feedback]
    mail(to: "pierre.caro@gmail.com", subject: "Nouveau commentaire de l'app UltraCompanion")
  end
end
