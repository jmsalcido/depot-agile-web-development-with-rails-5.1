class ApplicationController < ActionController::Base
  rescue_from Exception, with: :send_email_to_administrator

  private

  def send_email_to_administrator(exception)
    logger.warn exception
    # comment, I dont want to send emails each time I receive an exception, also, this is just the OrderMailer, not needed.
    # OrderMailer.received(Order.last).deliver_later
    throw exception
  end

end
