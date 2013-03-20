class CreateCodeStrings < ActiveRecord::Migration
  def change
    create_table :code_strings do |t|
      t.string :data
      t.integer :code_id

      t.timestamps
    end
  end
end
