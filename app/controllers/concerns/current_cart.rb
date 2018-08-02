module CurrentCart
  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @card.id
    # wouldnt it be better to search in the session first?
    # instead of recovering from an Exception?... ohwell...
  end
end
