class TypesController < ApplicationController

  def index

  end

  def show
    @type = Type.where(id: params[:id]).first
    @price = @type.cost
    @types = Type.all
    @appointments = []
    @type.appointments.each do |appointment|
      @appointments << appointment if appointment.users.size > 0 && appointment.class_date.utc > Time.now.utc && appointment.users.size < 9
      # 43200 is 12 hours (43200 seconds)
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
    @coupon = Coupon.new
    @redeemed = 0
    @user_error = 0
    # @card_error = 0
    @refund_policy = Refund.first
    session[:price] = nil
    session[:coupon] = nil
  end

  def create
    @appointment = Appointment.where(id: params[:user][:appointment_id]).first
    @type = Type.where(id: @appointment.type_id).first
    # if discount code applied
    if session[:price]
      @price = session[:price]
      @coupon = Coupon.where(id: session[:coupon]['id']).first
    else
      @price = @type.cost
    end

    if @type.books.size < 1
      @amount = @price * 100
    else
      if params['checkboxid']
        @amount = @price * 100
        @purchased = false
      else
        @amount = (@price * 100) + (@type.books.first.cost * 100)
        @purchased = true
      end
    end

    @user = User.new(
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      phone: params[:user][:phone],
      email: params[:stripeEmail],
      appointment_id: params[:user][:appointment_id],
      purchased_book: @purchased
    )

    if @user.save
      if session[:coupon]
        @coupon.limit -= 1
        @coupon.save
      end
      # send payment information to Stripe
      customer = Stripe::Customer.create(
        :description => "Class Date: #{@appointment.class_date.strftime("%B %d, %Y %I:%M %p")}",
        :email => params[:stripeEmail],
        :card  => params[:stripeToken]
      )
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => "Class Date: #{@appointment.class_date.strftime("%B %d, %Y %I:%M %p")}",
        :currency    => 'usd'
      )
      # send confirmation email (template: send_signup_email )
      UserNotifier.send_signup_email(@user).deliver_now
      # if appointment is a combo
      if @appointment.secondaries.size > 0
        @appointment.secondaries.each do |course|
          combo = Combo.where(
            primary_id: @appointment.id,
            secondary_id: course.id
          ).first
          user = User.new(
            first_name: params[:user][:first_name],
            last_name: "#{params[:user][:last_name]} (via combo ##{combo.id})",
            phone: params[:user][:phone],
            email: params[:stripeEmail],
            appointment_id: course.id,
            purchased_book: @purchased
          )
          user.save
        end
      end
    else
      @price = @type.cost
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
      @coupon = Coupon.new
      @redeemed = 0
      session[:price] = nil
      @user_error = 1
      @refund_policy = Refund.first
      render :template => 'types/show'
    end


  rescue Stripe::CardError => e
    flash[:error] = e.message
    @price = @type.cost
    @types = Type.all
    @appointments = []
    @type.appointments.each do |appointment|
      @appointments << appointment if appointment.users.size > 0 && appointment.class_date.utc > Time.now.utc && appointment.users.size < 9
      # 43200 is 12 hours (43200 seconds)
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
    @coupon = Coupon.new
    @redeemed = 0
    @user_error = 0
    @refund_policy = Refund.first
    session[:price] = nil
    session[:coupon] = nil
    @card_error = 1
    render :template => 'types/show'
  end



end
