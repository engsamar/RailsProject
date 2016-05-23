class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
  	uploaded_io = params[resource_name][:image]
	  File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
  	file.write(uploaded_io.read)
	end
	# params[resource_name][:image] << Rails.root.join('public', 'uploads', uploaded_io.original_filename) 
    params.require(:user).permit(:name,:image , :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit( :email, :image , :password, :password_confirmation, :current_password)
  end
end