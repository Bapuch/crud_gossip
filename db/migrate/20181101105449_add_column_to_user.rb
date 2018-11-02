class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_logged, :boolean, default: :false
  end
end
