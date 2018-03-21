class ChangeNotificationToDatetime < ActiveRecord::Migration[5.1]
  def up
    change_column :appointments, :notification, :datetime
  end

  def down
    change_column :appointments, :notification, :string
  end
end
