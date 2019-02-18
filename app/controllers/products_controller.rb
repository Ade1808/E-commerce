class ProductsController < InheritedResources::Base
	def index
		@products=Product.search(params[:search])
		@categories=Category.all
       
	end
	def show
		@product=Product.find(params[:id])
		@options=Option.joins(:product).where(:product=>(params[:id]))
		@cart_item=CartItem.new
	end

  private

    def product_params
      params.require(:product).permit(:name, :price, :stock, :category_id,:image,:status,:discount,:total,:sell,:discount_sell)
    end
end

