ActiveAdmin.register Product do
 scope :all 
 scope :unpublished
 scope :published
 permit_params :name,:price,:stock,:image,:category_id,:status,:discount,:sell,:discount_sell,options_attributes:[:id,:name,:value,:price,:product_id,:_destroy]
 form do |form|
 	form.object.sell=0
 	form.object.discount_sell=0
 	form.inputs do
     	form.inputs "Upload" do
      		form.input :image, required: true, as: :file
    	end
    	form.input :discount
    	form.input :status
 		form.input :category
 		form.input :name
 		form.input :price 
 		form.input :stock
 		form.has_many :options,new_record:true,allow_destroy:true do |po|
 			po.input :name
 			po.input :value
 			po.input :price
 		end
 	end
 	form.actions
 end
 index do
    
    id_column
    column :discount
    column :status
    column :name
    column :sell
    column :discount_sell
    column :stock
    column :total do |t|
    	t.total_price(t).round(2)
    end
    column :category 
    column 'Image', sortable: :image_file_name do |product| 
		  product.image.url
		 end
    column :created_at
    actions
  end
  show do 
 	attributes_table  do
 		row :total do |t|
    	 t.total_price(t).round(2)
        end
 		row :status
	 	row :name
	 	row :price do |t|
	 		t.price.round(2)
	 	end
	 	row :sell
	 	row :discount_sell
	 	row :discount
	 	row :stock
	 	row 'Image', sortable: :image_file_name do |product| 
			  product.image.url
		 end
		 table_for product.options do 
		 	column :options do |o|
		 		o.name
		 	end
		   column :Values do |v|
		   	v.value
		   end
		   column :Price do |p|
		   	p.price.round(2)
		   end
		 end
		 row :ProductToalPrice do |v|
    		v.price+=v.options.sum(&:price)
    		v.price.round(2)
   		end
	 	end
 	end
 	controller do
 		def update 
 			@product=Product.find(params[:id])
 			if @product.update( params.require(:product).permit(:name, :price, :stock, :category_id,:image,:status,:discount,:sell,:discount_sell,options_attributes:[:id,:name,:value,:price,:product_id,:_destroy]))
 				if @product.stock<=0
 					@product.status=0
 					@product.save
 				end
 				redirect_to admin_products_path			
 			end 
 		end
 	end

end
