class AddBioToPersonas < ActiveRecord::Migration[7.1]
  def change
    add_column :personas, :bio, :text
  end
end
