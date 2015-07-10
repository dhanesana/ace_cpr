class AppointmentsController < ApplicationController

  def index
    today_pdt = Time.now.utc + Time.zone_offset('PDT')
    @appointments = []
    Appointment.all.each do |appointment|
      if appointment.class_date > today_pdt
        @appointments << appointment unless appointment.users.size > 29
        break if @appointments.size > 4
      end
    end
    @user = User.new
  end

  def new
  end

  def create
  end

end
