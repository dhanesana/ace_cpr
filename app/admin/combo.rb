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
  index do
    column :id
    column 'Primary Type' do |combo|
      appt = Appointment.where(id: combo.primary_id).first
      appt.nil? ? "class deleted" : "#{appt.type.name}"
    end
    column 'Primary Date' do |combo|
      appt = Appointment.where(id: combo.primary_id).first
      appt.nil? ? "class deleted" : "#{appt.formated_date}"
    end
    column 'Primary Students' do |combo|
      appt = Appointment.where(id: combo.primary_id).first
      appt.nil? ? "class deleted" : "#{appt.users.size}"
    end
    column 'Secondary Type' do |combo|
      appt = Appointment.where(id: combo.secondary_id).first
      appt.nil? ? "class deleted" : "#{appt.type.name}"
    end
    column 'Secondary Date' do |combo|
      appt = Appointment.where(id: combo.secondary_id).first
      appt.nil? ? "class deleted" : "#{appt.formated_date}"
    end
    column 'Secondary Students' do |combo|
      appt = Appointment.where(id: combo.secondary_id).first
      appt.nil? ? "class deleted" : "#{appt.users.size}"
    end
    actions # view/edit/delete
  end

  form do |f|
    f.inputs "Combo Details" do
      f.input :primary_id, as: :select, collection: Appointment.all.collect {|appt| ["#{appt.formated_date} => #{appt.type.name}", appt.id] }
      f.input :secondary_id, as: :select, collection: Appointment.all.collect {|appt| ["#{appt.formated_date} => #{appt.type.name}", appt.id] }
    end
    f.actions
  end

end
