class CouponsController < ApplicationController

  def index
  end

  def new
  end

  def create
    puts '*' * 50
    input = params['coupon']['code']
    puts '*' * 50
    @type = Type.where(id: params[:type_id]).first
    @types = Type.all
    @appointments = []
    @type.appointments.each do |appointment|
      if appointment.class_date.utc > Time.now.utc
        @appointments << appointment unless appointment.users.size > 7
        break if @appointments.size > 4
      end
    end
    @appointments = @appointments.sort_by { |x| x.class_date }
    @user = User.new
    @coupon = Coupon.where(code: input, type_id: params[:type_id]).first
    @price = Type.where(id: params[:type_id]).first.cost
    if @coupon
      @type = Type.where(id: params[:type_id]).first
      puts '9' * 50
      p @coupon
      puts '9' * 50
      @price = @price - @coupon.discount.to_i
      session[:price] = @price
      @redeemed = 1
      render :template => 'types/show'
    else
      @type = Type.where(id: params[:type_id]).first
      @appointments = []
      @type.appointments.each do |appointment|
        if appointment.class_date.utc > Time.now.utc
          @appointments << appointment unless appointment.users.size > 7
          break if @appointments.size > 4
        end
      end
      @appointments = @appointments.sort_by { |x| x.class_date }
      @user = User.new
      @coupon = Coupon.new
      @price = Type.where(id: params[:type_id]).first.cost
      @redeemed = 0
      puts '()' * 25
      @invalid = 1
      render :template => 'types/show'
    end
  end

end
