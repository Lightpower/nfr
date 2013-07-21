class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :number, null: false
      t.integer :scores, null: false
      t.string  :name
      t.string  :desc

      t.references :format, null: false
    end

    add_index :levels, [:number, :format_id], unique: true
  end
end
