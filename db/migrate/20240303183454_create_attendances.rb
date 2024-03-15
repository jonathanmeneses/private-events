class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.references :attended_event, null: false, foreign_key: {to_table: :events}
      t.references :attendee, null: false, foreign_key: {to_table: :users}
      t.integer :invited_by_id, null: true
      t.string :status
      t.datetime :invited_date

      t.timestamps
    end

    add_index :attendances, :invited_by_id
    add_foreign_key :attendances, :users, column: :invited_by_id
    add_index :attendances, [:attended_event_id, :attendee_id], unique: true
  end
end
