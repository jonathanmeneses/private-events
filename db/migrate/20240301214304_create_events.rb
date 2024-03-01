class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.datetime :date
      t.string :title
      t.string :location

      t.timestamps
    end
  end
end
