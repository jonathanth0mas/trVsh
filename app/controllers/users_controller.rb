class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.create(user_parameters)
		if @user.save
			session[:user_id] = @user.id.to_s
			redirect_to users_path
		else 
		 	render :new
		end 		
	end

	def edit
	  
	  @user = User.find(params[:id])	 
	end

	def update
	  @user = User.find(params[:id])

	  if @user.update_attributes(user_parameters)
	    redirect_to users_path
	  else
	  	render "edit"
	  end
	end

	def destroy
	  @user =  User.find(params[:id]) 
	  @user.destroy
	  redirect_to logout_path	
	end

	private
	def user_parameters
		params.require(:user).permit(:name, :email, :password, :address, :bins, :date, :password_confirmation)
	end
end
