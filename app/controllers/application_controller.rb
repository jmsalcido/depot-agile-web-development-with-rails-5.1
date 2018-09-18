class ApplicationController < ActionController::Base
  rescue_from Exception, with: :send_email_to_administrator

  before_action :authorize

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: 'Please log in'
    end
  end

  private

  def send_email_to_administrator(exception)
    logger.warn exception
    # comment, I dont want to send emails each time I receive an exception, also, this is just the OrderMailer, not needed.
    # OrderMailer.received(Order.last).deliver_later
    throw exception
  end

end
