class CreateCodeStrings < ActiveRecord::Migration
  def change
    create_table :code_strings do |t|
      t.string     :data,    null: false, unique: true

      t.references :code
    end

    add_index :code_strings, :data, unique: true
    add_index :code_strings, :code_id
  end
end
