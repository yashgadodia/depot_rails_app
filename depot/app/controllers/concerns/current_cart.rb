#Rails makes the current session look like the hash of the controller, so we will store the ID of the cart in the 
#session by indexing it with the :cart_id symbol

module CurrentCart

    private 
        def set_cart #method starts by getting :cart_id from the session object and attempts to find the cart corresponding to this id
            #if not ofund, this method will create a new Cart and then store the ID of the created cart into the session
            @cart = Cart.find(session[:cart_id])
        rescue ActiveRecord::RecordNotFound
            @cart = Cart.create
            session[:cart_id] = @cart.id    
        end
end