class CreateArchiveCodeStrings < ActiveRecord::Migration
  def change
    create_table :archive_code_strings do |t|
      t.string :data,     null: false, unique: true
      t.string :color

      t.references :code, null: false
      t.references :game,         null: false
    end
  end
end
