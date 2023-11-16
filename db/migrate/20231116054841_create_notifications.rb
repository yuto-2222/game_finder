class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :subject, polymorphic: true
      t.references :user, foreign_key: true
      t.integer :action, null: false
      t.boolean :checked, null: false, default: false

      t.timestamps
    end
  end
end
