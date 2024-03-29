class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.float :salary
      t.references :position, null: false, foreign_key: true

      t.timestamps
    end
  end
end
