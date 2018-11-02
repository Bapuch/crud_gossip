class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :gossip, foreign_key: true
      t.references :user, foreign_key: true
      t.references :related_comment, index: true
      t.timestamps
    end
  end
end
