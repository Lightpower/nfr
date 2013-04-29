class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer  :number,     null: false, unique: true
      t.string   :name,       null: false, unique: true
      t.string   :format,     null: false
      t.datetime :start_date, null: false
      t.datetime :finish_date
      t.integer  :price
      t.string   :area
      t.text     :image_html
      t.text     :preview
      t.text     :legend
      t.text     :brief_place
      t.text     :dopy_list
      t.boolean  :is_active,   null: false, default: false
      t.boolean  :is_archived, null: false, default: false
      t.string   :prepare_url
      t.string   :discuss_url
    end

    add_index :games, :number, unique: true
    add_index :games, :name,   unique: true
    add_index :games, :format
    add_index :games, :start_date
  end
end
