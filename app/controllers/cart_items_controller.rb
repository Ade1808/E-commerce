class CartItemsController < InheritedResources::Base 
  def create
    @cart_product=CartItem.new(cart_item_params)
    product = Product.find_by_id(@cart_product.product_id)
    @cart_item=CartItem.find_by(product_id: product.id)
    quant=@cart_product.quantity
    value=@cart_product.validate_product_to_add_in_cart(quant,@cart_item,product,@current_cart)  
    respond_to do |format|
      format.html{redirect_to product_path(product) ,:notice=>value}
      format.js
    end
  end
  def destroy_cart_items
    @current_cart.cart_items.destroy_all
    @current_cart.destroy
    redirect_to products_path ,:notice=>"Your Cart is Drop"
  end
  def edit 
 		@cart_item=CartItem.find(params[:id])
 	end
 	def destroy
 	  @cart_item=CartItem.find(params[:id])
 	  @current_cart.total-= @cart_item.quantity
    @current_cart.total_price -= @cart_item.amount
    @current_cart.save
    @cart_item.destroy
 	  redirect_to cart_path(@current_cart)
 	end
  private
  def cart_item_params
    params.require(:cart_item).permit(:cart_id, :product_id, :quantity,:amount)
  end
end

