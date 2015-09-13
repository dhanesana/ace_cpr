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
    @appointments = @appointments.sort_by { |x| x.class_date }
    @user = User.new
    @coupon = Coupon.where(code: input, type_id: params[:type_id]).first
    @coupon = nil if @coupon.limit < 1
    @price = Type.where(id: params[:type_id]).first.cost
    if @coupon
      @type = Type.where(id: params[:type_id]).first
      @price = @price - @coupon.discount.to_i
      session[:price] = @price
      @redeemed = 1
      session[:coupon] = @coupon
      render :template => 'types/show'
    else
      @type = Type.where(id: params[:type_id]).first
      @appointments = []
      @type.appointments.each do |appointment|
        @appointments << appointment if appointment.users.size > 0 && appointment.class_date.utc > Time.now.utc && appointment.users.size < 9
        if (appointment.class_date.utc - 43200) > Time.now.utc
          next if @appointments.include? appointment
          @appointments << appointment unless appointment.users.size > 7
        end
      end
      @appointments = @appointments.sort_by { |x| x.class_date }
      @user = User.new
      @coupon = Coupon.new
      @price = Type.where(id: params[:type_id]).first.cost
      @redeemed = 0
      @invalid = 1
      render :template => 'types/show'
    end
  end

end
