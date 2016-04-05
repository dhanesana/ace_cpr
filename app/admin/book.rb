ActiveAdmin.register Book do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :list, :of, :attributes, :on, :model, :type_id, :title, :description, :cost, :image_url
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  index do
    column :title
    column :description
    column :type_id do |book|
      if book.type.nil?
        "type deleted"
      else
        Type.where(id: book.type_id).first.name
      end
    end
    column :image_url
    column :cost
    # column 'Enrolled' do |appointment|
    #   appointment.users.size
    # end
    actions # view/edit/delete
  end

end
