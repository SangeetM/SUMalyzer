class AddAvatarToPatients < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :avatar, :string
  end
end
