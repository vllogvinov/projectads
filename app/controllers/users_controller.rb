class UsersController < ApplicationController

	before_action :authenticate_user!
	
  def announcements
  	@announcements = User.find(params[:id]).announcements.includes(image_attachment: :blob)
  end
end	
