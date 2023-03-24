class FeedbackController < ApplicationController
  def create
    # Create a new instance of Feedback with the parameters passed from the view
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      # Send an email with the feedback details
      # FeedbackMailer.with(feedback: @feedback).feedback_email.deliver_now
      # Redirect to the live_path with a success message // Succes message doesn't appear
      redirect_to live_path, alert: "Votre commentaire a bien été envoyé. Merci pour votre aide !"
    else
      # Render the new feedback form with errors
      render :new
    end
  end

  private
  # Define a private method to allow only whitelisted parameters to be passed to the create method
  def feedback_params
    params.require(:feedback).permit(:name, :email, :suggestion)
  end
end
