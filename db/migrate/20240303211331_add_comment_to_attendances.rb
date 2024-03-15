class AddCommentToAttendances < ActiveRecord::Migration[7.1]
  def change
    add_column :attendances, :comment, :text
  end
end
