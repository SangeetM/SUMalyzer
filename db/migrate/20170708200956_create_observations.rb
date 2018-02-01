class CreateObservations < ActiveRecord::Migration[5.1]
  def change
    create_table :observations do |t|
      t.integer :peak_flow
      t.integer :long_term_medication_strokes
      t.integer :prn_medication_strokes
      t.integer :emergency_medication_units
      t.text    :comment
      t.boolean :vacation
      t.boolean :pollen
      t.float   :latitude
      t.float   :longitude
      t.string  :city

      t.timestamps
    end
  end
end
