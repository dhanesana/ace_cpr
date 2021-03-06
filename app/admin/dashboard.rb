ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1
  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do

      column do
        panel "Recently Created Appointments (30)" do
          table_for Appointment.order('created_at desc').limit(30).each do |appointment|
            puts '^' * 50
            p appointment
            column("Date")    {|appt| link_to(appt.formated_date, admin_appointment_path(appt)) }
            column(:type) do |appt|
              if appt.type.nil?
                "type deleted"
              else
                link_to(appt.type.name, admin_appointment_path(appt))
              end
            end
            column("Students")    {|appt| link_to(appt.users.size, admin_appointment_path(appt)) }
          end
        end
      end

      column do
        panel "Recent Users (30)" do
          table_for User.order('created_at desc').limit(30).each do |stdt|
            column(:id)
            column("name")    {|student| link_to("#{student.first_name} #{student.last_name}", admin_user_path(student)) }
            column(:email)    {|student| link_to(student.email, admin_user_path(student)) }
            column("Purchased Book?") do |student|
              if student.purchased_book == false
                "No"
              else
                link_to("Yes", admin_appointment_path(student.appointment))
              end
            end
            column("class") do |student|
              if student.appointment.nil?
                "class deleted"
              else
                link_to("#{student.appointment.formated_date}", admin_appointment_path(student.appointment))
              end
            end
          end
        end
      end

    end
  end
end
