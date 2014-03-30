class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string     :name,   null: false
      t.references :domain, null: false
    end
  end
end
