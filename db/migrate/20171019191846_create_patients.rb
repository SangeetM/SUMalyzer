class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.datetime :birthday
      t.references :user

      t.timestamps
    end
  end
end
