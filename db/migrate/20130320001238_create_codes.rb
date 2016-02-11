class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.integer :number,  null: false
      t.string  :name,    null: false
      t.text    :info
      t.string  :ko,      null: false
      t.string  :color
      t.float   :bonus,   null:false, default: 0

      t.references :task
      t.references :game,   null: false
    end

    add_index :codes, :number
    add_index :codes, :ko
    add_index :codes, :game_id
  end
end
