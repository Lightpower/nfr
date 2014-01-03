# encoding: UTF-8
class UpdateGameFormats < ActiveRecord::Migration
  def up
    change_table :games do |t|
      t.remove :format
      t.change :number, :string, null: false

      t.references :format

      t.index :format_id
      t.remove_index :number
    end

    unless Rails.env.test?
      Project.create(id: 1, name: 'NeFoRmat', owner: 'Виталий Lightpower Бескровный', css_class: 'neformat')

      Format.create(id: 1,  project_id: 1, name: 'NeDostRoy', organizer: 'Lightpower', css_class: 'nedostroy', show_in_archives: true)
      Format.create(id: 2,  project_id: 1, name: 'Game', organizer: 'Lightpower', css_class: 'game', show_in_archives: true)

      Game.all.each do |game|
        game.format_id = 11
        game.game_type = 'conquest'
        game.save!
      end
    else
      Game.delete_all
    end





  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
