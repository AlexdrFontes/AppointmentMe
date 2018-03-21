class ChangeNotificationToDatetime < ActiveRecord::Migration[5.1]
  def up
    remove_column :appointments, :notification, :string
    add_column :appointments, :notification, :datetime
  end

  def down
    remove_column :appointments, :notification, :datetim
    add_column :appointments, :notification, :string
  end
end
