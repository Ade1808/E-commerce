ActiveAdmin.register Order do
	actions :all ,except:[:new]
	scope   :all
	scope   :Acceptance_Pending
	scope   :Approved
	scope   :Not_Approved
  permit_params :user_id,:total_amount,:status,:quantity
  form do |form|
  	form.inputs do 
  		table_for order.user do |u|
  		column  :user do |u_s|
  			u_s.email
  		end 
  		end
  		form.input :status
  	end
  	form.actions
  end
  controller do 
    def update 
      @order=Order.find(params[:id])
      if @order.update(params.require(:order).permit(:user_id, :total_amount,:status))
        if @order.status==1
         OrderMailer.order_confirmation(@order.user).deliver
         redirect_to  admin_orders_path
        else
         OrderMailer.order_not_approved(@order.user).deliver
         redirect_to  admin_orders_path
        end
      end
    end 
  end
   #See permitted parameters documentation:
    # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
end
