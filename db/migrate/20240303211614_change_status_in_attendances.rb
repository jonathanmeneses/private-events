class ChangeStatusInAttendances < ActiveRecord::Migration[7.1]
  def up
    change_column :attendances, :status, 'integer USING CAST(status AS integer)'
  end

  def down
    change_column :attendances, :status, :string
  end
end
