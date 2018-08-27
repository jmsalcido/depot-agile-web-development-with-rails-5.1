class Order < ApplicationRecord

  require 'pago'

  has_many :line_items, dependent: :destroy
  belongs_to :pay_type

  validates :name, :address, :email, presence: true
  validates :pay_type, presence: true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  # TODO this method should be on a different part or at least the payment processor should be sent to this.
  def charge!(pay_type_params)
    payment_details = {}

    case pay_type.name
    when 'Check'
      payment_method = :check
      payment_details[:routing] = pay_type_params[:routing_number]
      payment_details[:account] = pay_type_params[:account_number]
    when 'Credit Card'
      payment_method = :credit_card
      month, year = pay_type_params[:expiration_date].split(//)
      payment_details[:cc_num] = pay_type_params[:credit_card_number]
      payment_details[:expiration_month] = month
      payment_details[:expiration_year] = year
    when 'Purchase Order'
      payment_method = :po
      payment_details[:po_num] = pay_type_params[:po_number]
    else
      raise ArgumentError('Foo')
    end

    payment_result = Pago.make_payment(
      order_id: id,
      payment_method: payment_method,
      payment_details: payment_details
    )

    if payment_result.succeeded?
      OrderMailer.received(self).deliver_later
    else
      OrderMailer.failure(self, payment_result.message).deliver_later
      raise payment_result.error
    end
  end

end
