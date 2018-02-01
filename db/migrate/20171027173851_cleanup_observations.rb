class CleanupObservations < ActiveRecord::Migration[5.1]
  def change
    remove_column :observations, :peak_flow
    remove_column :observations, :long_term_medication_strokes
    remove_column :observations, :prn_medication_strokes
    remove_column :observations, :emergency_medication_units
    remove_column :observations, :vacation
    remove_column :observations, :pollen
  end
end
