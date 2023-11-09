class CreateUsefuls < ActiveRecord::Migration[6.1]
  def change
    create_table :usefuls do |t|
      t.integer :user_id
      t.integer :review_id

      t.timestamps
    end
  end
end
