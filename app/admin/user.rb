ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model, :first_name, :last_name, :email, :phone, :appointment_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  form do |f|
    utc = Time.now.utc
    today_pdt = utc + Time.zone_offset('PDT')
    f.inputs "Student Details" do
      f.input :appointment_id, as: :select, collection: (Appointment.all.sort_by &:class_date).select { |a| a.class_date > today_pdt }.collect {|appointment| [appointment.class_date.strftime("%m-%d-%Y %I:%m %p"), appointment.id] }
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
    end
    f.actions
  end

  index do
    column :last_name
    column :first_name
    column :email
    column :phone
    column :appointment_id do |user|
      Appointment.where(id: user.appointment_id).first.formated_date
    end
    actions # view/edit/delete
  end

  # show do |user|
  #   attributes_table do
  #     row :first_name
  #     row :last_name
  #   end
  #   # panel("Students") do
  #   #   table_for(appt.users) do
  #   #     column "Users" do |user|
  #   #       "#{user.first_name} #{user.last_name}"
  #   #     end
  #   #   end
  #   # end
  #   active_admin_comments
  # end

end
