require 'ostruct'

class Pago
  def self.make_payment(
      order_id:,
      payment_method:,
      payment_details:
    )

    case payment_method
    when :check
      Rails.logger.info 'Processing check: ' \
                        "#{payment_details.fetch(:routing)}/" \
                        "#{payment_details.fetch(:account)}"
      failure = payment_details.fetch(:account) == 'failure'
      message = 'Could not process your check correctly.'
    when :credit_card
      Rails.logger.info 'Processing credit_card: ' \
                        "#{payment_details.fetch(:cc_num)}/" \
                        "#{payment_details.fetch(:expiration_month)}/" \
                        "#{payment_details.fetch(:expiration_year)}"
      failure = payment_details.fetch(:cc_num) == '4111111111111112'
      message = 'Your credit card was declined by the issuer bank.'
    when :po
      Rails.logger.info 'Processing purchase order: ' \
                        "#{payment_details.fetch(:po_num)}"
      failure = payment_details.fetch(:po_num) == 321
      message = 'Purcharse order is not valid anymore.'
    else
      raise "Unknown payment_method #{payment_method}"
    end
    sleep 3 unless Rails.env.test?

    Rails.logger.info "Done Processing Payment for #{order_id}"

    if failure
      OpenStruct.new(succeeded?: false, message: message)
    else
      OpenStruct.new(succeeded?: true)
    end
  end
end