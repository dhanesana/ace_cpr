ActiveAdmin.register Appointment do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model, :admin_user_id, :class_date, :type_id
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
    column 'Enrolled' do |appointment|
      appointment.users.size
    end
    actions # view/edit/delete
  end

  form do |f|
    f.inputs "Appointment Details" do
      f.input :admin_user_id, as: :select, collection: AdminUser.all.collect {|admin| [admin.email, admin.id] }
      f.input :type_id, as: :select, collection: Type.all.collect {|type| [type.name, type.id] }
      f.input :class_date
    end
    f.actions
  end

  show do |appt|
    attributes_table do
      row :class_date
      row :admin_user
      row :type_id
    end
    panel("Students") do
      table_for(appt.users) do
        column "Name" do |user|
          link_to("#{user.first_name} #{user.last_name}", admin_user_path(user))
        end
        column "Email" do |user|
          link_to("#{user.email}", admin_user_path(user))
        end
        column "Phone" do |user|
          link_to("#{user.formatted_phone}", admin_user_path(user))
        end
      end
    end
    active_admin_comments
  end

end
