class CreateExperience < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :null
      t.integer :one
      t.integer :one_p
      t.integer :two
      t.integer :two_p
      t.integer :three
      t.integer :tree_p
      t.integer :nonstandard
      t.integer :author

      t.references :user,   null: false
      t.references :format, null: false

    end

    add_index :experiences, [:user_id, :format_id], uniq: true
  end
end
