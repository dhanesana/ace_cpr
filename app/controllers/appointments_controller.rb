class AppointmentsController < ApplicationController

  def index
    @types = Type.all.sort { |a, b| a.order <=> b.order }
    @user = User.new
    @about = About.last
    @headline = Headline.last
    @headline_two = HeadlineTwo.last
    @headline_three = HeadlineThree.last
    @coupon = Coupon.new
    @header = MainHeaderImage.first
    @redeemed = 0
    @about_list = AboutList.first
    session[:price] = nil
  end

  def new
  end

end
