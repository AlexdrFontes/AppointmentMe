class RenameDateAtAppointments < ActiveRecord::Migration[5.1]
 def up
  change_column :appointments, :appointment_date, :datetime
 end

 def down
  change_column :appointments, :appointment_date, :date
 end
end
