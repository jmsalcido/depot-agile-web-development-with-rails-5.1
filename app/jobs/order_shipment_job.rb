class OrderShipmentJob < ApplicationJob
  queue_as :default

  def perform(order)
    OrderMailer.shipped(order).deliver_later
  end
end
