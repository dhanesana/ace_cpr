ActiveAdmin.register Price do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :cost, :type_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

index do
  column :type
  column :cost
  # column 'Enrolled' do |appointment|
  #   appointment.users.size
  # end
  actions # view/edit/delete
end

# controller do
#   actions :all, except: [:create, :destroy]
# end

# config.clear_action_items!

end
