class StoreController < ApplicationController
  include CurrentCart

  skip_before_action :authorize

  before_action :set_cart

  def index
    if session[:visit_counter].nil?
      session[:visit_counter] = 1
    else
      session[:visit_counter] += 1
    end

    @visit_counter = session[:visit_counter]
    @products = Product.order(:title)
  end
end
