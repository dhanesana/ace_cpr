ActiveAdmin.register Combo do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model, :primary_id, :secondary_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  form do |f|
    f.inputs "Combo Details" do
      f.input :primary_id, as: :select, collection: Appointment.all.collect {|appt| ["#{appt.type.name} => #{appt.formated_date}", appt.id] }
      f.input :secondary_id, as: :select, collection: Appointment.all.collect {|appt| ["#{appt.type.name} => #{appt.formated_date}", appt.id] }
    end
    f.actions
  end

end
