class FeedbackController < ApplicationController
  def create
    @feedback = FeedbackMailer.new(feedback_params)

    if @feedback.save
      # Send email here
      FeedbackMailer.with(feedback: @feedback).feedback_email.deliver_now

      redirect_to root_path, notice: "Votre commentaire a bien été envoyé. Merci pour votre aide !"
    else
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :suggestion)
  end

end
