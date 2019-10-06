# encoding: UTF-8
class AddDomainToTables < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :domain
    end
    change_table :games do |t|
      t.references :domain
    end

    domain = Domain.create(name: 'default', full_name: 'NeFoRmat Київ', owner: 'Lightpower')

    Game.all.each do |obj|
      obj.domain_id = domain.id
      obj.save
    end

    change_column :users, :domain_id, :integer, null: false
    change_column :games, :domain_id, :integer, null: false

    add_index :users, :domain_id
    add_index :games, :domain_id
  end
end