class CreateUserParents < ActiveRecord::Migration
  def change
    create_table :user_parents do |t|
      t.references :user,        null: false
      t.string     :parent_type, default: 'User'
      t.integer    :parent_id
    end

    add_index :user_parents, :user_id
  end
end
