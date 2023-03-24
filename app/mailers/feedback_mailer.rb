class FeedbackMailer < ApplicationMailer
  def feedback_email
    Rails.logger.info("FeedbackMailer feedback_email method called")
    @feedback = params[:feedback]
    mail(to: "jegatjc@gmail.com", subject: "Nouveau commentaire de l'app UltraCompanion")
  end
end
