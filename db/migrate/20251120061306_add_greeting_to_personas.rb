class AddGreetingToPersonas < ActiveRecord::Migration[7.1]
  def change
    add_column :personas, :greeting, :text
  end
end
