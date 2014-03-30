class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name,              null: false
      t.string :full_name,         null: false
      t.string :owner,             null: false

    end

    add_index :domains, :name,      unique: true
    add_index :domains, :full_name, unique: true
  end
end
