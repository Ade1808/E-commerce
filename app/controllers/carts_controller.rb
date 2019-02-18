class CartsController < InheritedResources::Base
	def show 
		@cart_items=CartItem.joins(:cart,:product).where(:cart=>params[:id])
	end 
	
  private
 
    def cart_params
      params.require(:cart).permit(:total)
    end
end

