ActiveAdmin.register Appointment do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model, :admin_user_id, :class_date
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  index do
    column :class_date
    column :admin_user
    actions # view/edit/delete
  end

  form do |f|
    f.inputs "Appointment Details" do
      f.input :admin_user_id, as: :select, collection: AdminUser.all.collect {|admin| [admin.email, admin.id] }
      f.input :class_date
    end
    f.actions
  end

  # show do
  #   attributes_table do
  #     row :class_date

  #   end
  #   active_admin_comments
  # end

end
