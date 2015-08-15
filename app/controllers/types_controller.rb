class TypesController < ApplicationController

  def show
    @type = Type.where(id: params[:id]).first
    @types = Type.all
    @appointments = []
    Appointment.all.each do |appointment|
      if appointment.class_date.utc > Time.now.utc
        @appointments << appointment unless appointment.users.size > 7
        break if @appointments.size > 4
      end
    end
    @appointments = @appointments.sort_by { |x| x.class_date }
    @user = User.new
    @coupon = Coupon.new
    # @price = Price.last.cost.to_i
    @redeemed = 0
    session[:price] = nil
  end

end
