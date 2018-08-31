class OrderService
  require 'pago'

  attr_reader :payment_proc

  def initialize(payment_proc = Pago)
    @payment_proc = payment_proc
  end

  def charge!(order, pay_type_params)
    charge_details = order.charge! pay_type_params
    payment_result = @payment_proc.make_payment(
      order_id: charge_details.order_id,
      payment_method: charge_details.payment_method,
      payment_details: charge_details.payment_details
    )

    if payment_result.succeeded?
      OrderMailer.received(order).deliver_later
    else
      OrderMailer.failure(order, payment_result.message).deliver_later
      raise payment_result.message
    end
  end

end