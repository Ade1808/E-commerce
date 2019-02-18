class ApplicationController < ActionController::Base
    before_action :create_cart
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
    
	def current_cart
		@current_cart = Cart.find_by_id(session[:cart_id])
	end
	
	private

	def create_cart
		unless current_cart
			@current_cart = Cart.new
			@current_cart.total=0
			@current_cart.total_price=0.0000
			@current_cart.save
			session[:cart_id] = @current_cart.id
		else
			current_cart
		end
	end
    
    protected 
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) {|s| s.permit(:role,:email,:password,:password_confirmation,:remember_me)}
		devise_parameter_sanitizer.permit(:sign_in) {|s| s.permit(:email,:password,:remember_me)}
		devise_parameter_sanitizer.permit(:account_update) {|s| s.permit(:role,:email,:password,:password_confirmation,:remember_me)}
	

	end

end
