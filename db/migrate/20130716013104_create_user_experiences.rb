class CreateUserExperiences < ActiveRecord::Migration
  def change
    create_table :user_experiences do |t|
      t.integer :null
      t.integer :one
      t.integer :one_p
      t.integer :two
      t.integer :two_p
      t.integer :three
      t.integer :tree_p
      t.integer :nonstandard
      t.integer :author
      t.integer :level, default: 0

      t.references :user,   null: false
      t.references :format, null: false

    end

    add_index :user_experiences, [:user_id, :format_id], uniq: true
  end
end
