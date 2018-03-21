class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.string :title
      t.string :email
      t.date :appointment_date
      t.string :notification

      t.timestamps
    end
  end
end
