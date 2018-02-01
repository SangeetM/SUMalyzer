class AddPatientIdToObservations < ActiveRecord::Migration[5.1]
  def change
    add_column :observations, :patient_id, :integer
  end
end
