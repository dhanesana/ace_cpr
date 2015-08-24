ActiveAdmin.register AboutBullet do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model, :bullet, :about_list_id, :order
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

# controller do
#   actions :all, except: [:create, :destroy]
# end

end
