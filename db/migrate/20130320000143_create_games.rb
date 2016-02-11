class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string   :number,     null: false
      t.string   :name,       null: false
      t.string   :format,     null: false
      t.string   :game_type,  null: false, default: 'conquest'
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
      t.boolean  :is_visible,        default: false, null: false
      t.boolean  :auto_teams_accept, default: false, null: false
      t.string   :prepare_url
      t.string   :discuss_url
      t.string   :statistics_url
      t.string   :scenario_url

      t.references :format
    end

    add_index :games, :name
    add_index :games, :start_date
    add_index :games, :format_id
  end
end