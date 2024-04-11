class CreateEarthquakes < ActiveRecord::Migration[7.0]
  def change
    create_table :earthquakes do |t|
      t.string :external_id
      t.float :magnitude
      t.string :place
      t.datetime :time
      t.boolean :tsunami
      t.string :mag_type
      t.string :title
      t.float :longitude
      t.float :latitude
      t.string :external_url
      t.string :type
      t.timestamps
    end
  end
end
