class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :quantity , numericality: { only_integer: true,greater_than:0  } ,presence:true
  validates :amount,numericality:{greater_than_or_equal:0.1}	
 def validate_product_to_add_in_cart(quant,cart_item,product,cart)
	 	if quant.nil? or quant <= 0.0
	    "Order Cannot Be Place On This Quantity"	  
	  else
	    if cart_item.present? && product.id==cart_item.product_id
	      if product.stock-product.cart_item.quantity<quant
	        "Product Quantity Should be  less then #{product.stock-product.cart_item.quantity.to_i}"  
	      else 
	        cart_item.quantity += quant
	        if product.discount<=0.0
	          cart_item.amount+=product.total.to_f*quant.to_f
	        else
	          cart_item.amount+=(product.total.to_f-product.discount_price(product))*quant.to_f
	        end
	        cart_item.save
	        if cart.total.nil?
	          cart.total=0
	        end
	        cart.total+=quant
	        cart.total_price+=product.total.to_f*quant.to_f
	        cart.save
	        "Added To Cart"
	      end
	    else  
	      if product.stock<quant.to_f
	        "Product Quantity Should be  less then #{product.stock.to_i}"
	      elsif product.stock>=quant.to_f
	        if product.discount<=0.0
	          amount=product.total.to_f*quant.to_f
	        else
	          amount=(product.total.to_f-product.discount_price(product))*quant.to_f
	        end
	        product.create_cart_item(product_id:product.id, cart_id: cart.id,quantity: quant,amount: amount)
	        cart.total+=quant.to_f
	        if  cart.total_price.nil?  
	          cart.total_price=0.0
	        end
	        cart.total_price+=amount
	        cart.save
	        "Added To Cart" 
	      end 
	    end
	  end
	end    
end

