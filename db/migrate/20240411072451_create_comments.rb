class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :feature_id
      t.text :body

      t.timestamps
    end
  end
end
