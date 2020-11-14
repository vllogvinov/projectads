ActiveAdmin.register Announcement do

  permit_params :title, :content, :published_at, :user_id

  #index do
  #selectable_column
  #id_column
   #state_column :status
  #end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :content, :announcement_type, :user_id, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :content, :announcement_type, :user_id, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
