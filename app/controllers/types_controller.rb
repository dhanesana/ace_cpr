class TypesController < ApplicationController

  def index

  end

  def show
    @type = Type.where(id: params[:id]).first
    @price = @type.cost
    @types = Type.all
    @appointments = []
    @type.appointments.each do |appointment|
      if appointment.class_date.utc > Time.now.utc
        @appointments << appointment unless appointment.users.size > 7
        # break if @appointments.size > 4
      end
    end
    @appointments = @appointments.sort_by { |x| x.class_date }
    # @appointments.slice!(0..4)
    @user = User.new
    @coupon = Coupon.new
    # @price = Price.last.cost.to_i
    @redeemed = 0
    @user_error = 0
    @refund_policy = Refund.all.first
    session[:price] = nil
    session[:coupon] = nil
  end

  def create
    @user = User.new(
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      phone: params[:user][:phone],
      email: params[:stripeEmail],
      appointment_id: params[:user][:appointment_id]
    )
    if @user.save
      if session[:coupon]
        @coupon = Coupon.where(id: session[:coupon]['id']).first
        @coupon.limit -= 1
        @coupon.save
      end
      @appointment = Appointment.where(id: @user.appointment_id).first
      @type = Type.where(id: @appointment.type_id).first
      @price = @type.cost
      @price = session[:price] if session[:price]
      @amount = @price * 100

      customer = Stripe::Customer.create(
        :description => "Class Date: #{Appointment.where(id: params[:user][:appointment_id]).first.class_date.strftime("%B %d, %Y %I:%M %p")}",
        :email => params[:stripeEmail],
        :card  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => "Class Date: #{Appointment.where(id: params[:user][:appointment_id]).first.class_date.strftime("%B %d, %Y %I:%M %p")}",
        :currency    => 'usd'
      )
      @about = About.last
      @refund_policy = Refund.all.first
    else
      @appointment = Appointment.where(id: params['user']['appointment_id']).first
      @type = Type.where(id: @appointment.type_id).first
      @price = @type.cost
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
      @coupon = Coupon.new
      @redeemed = 0
      session[:price] = nil
      @user_error = 1
      @refund_policy = Refund.all.first
      render :template => 'types/show'
    end


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end



end
