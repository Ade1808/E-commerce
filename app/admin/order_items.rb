ActiveAdmin.register OrderItem do
	actions :all,except:[:new]
	permit_params :product_id,:order_id,:quantity,:amount

end
