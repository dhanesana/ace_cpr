class CouponsController < ApplicationController

  # def index
  # end

  # def new
  # end

  def create
    input = params['coupon']['code']
    @refund_policy = Refund.all.first
    @type = Type.where(id: params[:type_id]).first
    @types = Type.all
    @appointments = []
    @type.appointments.each do |appointment|
      @appointments << appointment if appointment.users.size > 0 && appointment.class_date.utc > Time.now.utc && appointment.users.size < 9
      if (appointment.class_date.utc - 43200) > Time.now.utc
        next if @appointments.include? appointment
        @appointments << appointment unless appointment.users.size > 7
      end
    end
    # remove combo appointment ifs secondary courses are full
    @appointments.each do |appt|
      if appt.secondaries.size > 0
        appt.secondaries.each do |secondary|
          @appointments.delete(appt) if secondary.users.size > 7
        end
      end
    end
    @appointments = @appointments.sort_by { |x| x.class_date }
    @user = User.new
    @price = Type.where(id: params[:type_id]).first.cost
    @coupon = Coupon.where(code: input, type_id: params[:type_id]).first
    # coupon can't be redeemed if its limit has reached 0
    if @coupon
      @coupon = nil if @coupon.limit < 1
    end
    if @coupon
      @price = @price - @coupon.discount.to_i
      session[:price] = @price
      @redeemed = 1
      session[:coupon] = @coupon
      render :template => 'types/show'
    else
      @coupon = Coupon.new
      @redeemed = 0
      @invalid = 1
      render :template => 'types/show'
    end
  end

end
