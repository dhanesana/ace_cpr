class AppointmentsController < ApplicationController

  def index
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
    @about = About.last
    @headline = Headline.last
    @headline_two = HeadlineTwo.last
    @headline_three = HeadlineThree.last
    @coupon = Coupon.new
    # @price = Price.last.cost.to_i
    @redeemed = 0
    session[:price] = nil
  end

  def new
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
      # Amount in cents
      @price = Price.last.cost.to_i
      @price = session[:price] if session[:price]
      puts '8' * 50
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
      @appointment = Appointment.where(id: @user.appointment_id).first
      @about = About.last
    else
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
      @price = Price.last.cost.to_i
      @redeemed = 0
      session[:price] = nil
    end


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

end
