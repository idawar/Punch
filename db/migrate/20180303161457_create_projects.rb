class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :client_id, foreign_key: true, index: true

      t.timestamps
    end
  end
end
