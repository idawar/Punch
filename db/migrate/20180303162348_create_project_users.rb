class CreateProjectUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :project_users do |t|
      t.references :user, foreign_key: true, index: true
      t.references :project, foreign_key: true, index: true
    end
  end
end
