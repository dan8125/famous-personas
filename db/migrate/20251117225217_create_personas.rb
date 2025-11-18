class CreatePersonas < ActiveRecord::Migration[7.1]
  def change
    create_table :personas do |t|
      t.string :name
      t.string :category
      t.text :system_prompt
      t.text :content

      t.timestamps
    end
  end
end
