class FeedbackMailer < ApplicationMailer
  def feedback_email
    # Log the call to this method
    Rails.logger.info("FeedbackMailer feedback_email method called")
    # Set the instance variable @feedback to the feedback parameter passed to the method
    @feedback = params[:feedback]
    # Send an email to a hardcoded address with the feedback details as the body and a subject line
    mail(to: "jegatjc@gmail.com", subject: "Nouveau commentaire de l'app UltraCompanion")
  end
end
