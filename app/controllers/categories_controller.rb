class CategoriesController < InheritedResources::Base
	def show 
		@category=Category.find(params[:id])
		@products=Product.joins(:category).where(:status=>'published').where(:category=>params[:id])
		@cart_item=CartItem.new
	end	
    private

    def category_params
      params.require(:category).permit(:name,:discount,:product_price)
    end
end

