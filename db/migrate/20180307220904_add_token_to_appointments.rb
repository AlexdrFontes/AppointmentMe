class AddTokenToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :token, :string
  end
end
