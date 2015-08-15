class TypesController < ApplicationController

  def show
    @type = Type.where(id: params[:id]).first
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
    # @price = Price.last.cost.to_i
    @redeemed = 0
    session[:price] = nil
  end

  def create
    # @type = Type.where(id: params[:id]).first
    @user = User.new(
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      phone: params[:user][:phone],
      email: params[:stripeEmail],
      appointment_id: params[:user][:appointment_id]
    )
    if @user.save
      # Amount in cents
      @appointment = Appointment.where(id: @user.appointment_id).first
      puts '75' * 20
      p @appointment.type_id
      puts '-' * 50
      @type = Type.where(id: @appointment.type_id).first
      puts '8' * 50
      @price = @type.cost
      @price = session[:price] if session[:price]
      p @price
      @amount = @price * 100

      customer = Stripe::Customer.create(
        :description => "Class Date: #{Appointment.where(id: params[:user][:appointment_id]).first.class_date.strftime("%B %d, %Y %I:%m %p")}",
        :email => params[:stripeEmail],
        :card  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => "Class Date: #{Appointment.where(id: params[:user][:appointment_id]).first.class_date.strftime("%B %d, %Y %I:%m %p")}",
        :currency    => 'usd'
      )
      @about = About.last
    else
      puts '5' * 50
      @appointments = []
      Appointment.all.each do |appointment|
        if appointment.class_date.utc > Time.now.utc
          @appointments << appointment unless appointment.users.size > 7
          break if @appointments.size > 4
        end
      end
      @appointments = @appointments.sort_by { |x| x.class_date }
      @user = User.new
      @about = About.last
      @headline = Headline.last
      @headline_two = HeadlineTwo.last
      @headline_three = HeadlineThree.last
      @coupon = Coupon.new
      # @price = @type.cost
      @redeemed = 0
      session[:price] = nil
    end


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end



end
