class AddInviteOnlyToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :invite_only, :boolean, default: false
  end
end
