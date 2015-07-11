ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1
  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Appointments (10)" do
          table_for Appointment.order('class_date asc').limit(10).each do |student|
            column("Date")    {|appt| link_to(appt.formated_date, admin_appointment_path(appt)) }
            column("Students")    {|appt| link_to(appt.users.size, admin_appointment_path(appt)) }
          end
        end
      end

      column do
        panel "Recent Users (10)" do
          table_for User.order('created_at desc').limit(10).each do |student|
            column("name")    {|student| link_to("#{student.first_name} #{student.last_name}", admin_user_path(student)) }
            column(:email)    {|student| link_to(student.email, admin_user_path(student)) }
          end
        end
      end
    end
  end
end
