class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@user = current_user
  	@installations =Installation.all
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
    	flash[:notice] = 'Operacja wykonana poprawnie'
      redirect_to(:action => 'index')
    else
    	flash[:notice] = 'Coś poszło nie tak'
      @user = current_user
  		@installations =Installation.all
      render('index')
    end
  end


  def user_params
    params.require(:user).permit(:is_active, :critical, :delay, installation_ids: [])
  end
end
