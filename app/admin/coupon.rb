ActiveAdmin.register Coupon do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model, :code, :discount, :type_id, :limit

  index do
    column 'Class Type' do |coupon|
      Type.where(id: coupon.type_id).first.name
    end
    column :code
    column :discount
    column :limit
    actions # view/edit/delete
  end

end
