class CouponsController < ApplicationController

  def index
  end

  def new
  end

  def create
    puts '*' * 50
    input = params['coupon']['code']
    puts '*' * 50
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
    @coupon = Coupon.where(code: input).first
    @price = Price.last.cost.to_i
    if @coupon
      puts '9' * 50
      p @coupon
      puts '9' * 50
      @price = @price - @coupon.discount.to_i
      session[:price] = @price
      @redeemed = 1
      @contact = Contact.first
      render :template => 'appointments/index'
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
      @contact = Contact.first
      puts '()' * 25
      @invalid = 1
      render :template => 'appointments/index'
    end
  end

end
