class OrdersController < InheritedResources::Base
   before_action :authenticate_user!, :new_charge_path 
  def show
  	@order=Order.find(params[:id])
  	@order_items=OrderItem.joins(:product,:order).where(:order=>params[:id])
  end
  
  def add_order_items

	    if @current_cart.cart_items.empty?
	    	redirect_to cart_path(@current_cart) ,:notice=>"Cart is empty"
	    elsif @current_cart.total_price.to_f >= 500.0
		    @order=Order.create(user_id:current_user.id,total_amount:0,quantity:0)
		    @current_cart.cart_items.each do |o|
			  	if o.product.stock>=o.quantity
			  		OrderItem.create(product_id: o.product_id,order_id:@order.id,quantity: o.quantity,amount:o.amount)
			  		@order.total_amount += o.amount
			  		@order.quantity += o.quantity.to_i
			  		product=Product.find(o.product_id)
			  		product.stock-=o.quantity.to_f
			  		if product.discount>0.0
			  			if product.discount_sell.nil?
			  				product.discount_sell=0
			  			end
			  			product.discount_sell+=o.quantity
			  		else
			  			if product.sell.nil?
			  				product.sell=0
			  			end
			  			product.sell+=o.quantity
			  		end
			  		product.save
			  		if product.stock<1
			  			product.status=0
			  			product.save
			  		else	
			  			product.save
			  		end	
			  	end
		    end
			if @order.save
			 	@current_cart.cart_items.destroy_all
			 	@current_cart.destroy
			   	OrderMailer.order_place_confirmation(current_user).deliver
			 	redirect_to order_path(@order)
			else
			  redirect_to home_page_index_path
			end
		else	
			redirect_to cart_path(@current_cart) ,:notice=>" Order Amount Should be Greater Then 500"
    	end
    end

  private
    def order_params
      params.require(:order).permit(:user_id, :total_amount,:status,:quantity)
    end


end

