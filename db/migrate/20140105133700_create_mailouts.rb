class CreateMailouts < ActiveRecord::Migration
  def change
    create_table :mailouts do |t|
      t.string   :from,         null: false
      t.text     :to,           null: false
      t.text     :subject
      t.text     :body
      t.text     :attachments
      t.datetime :sent_at

      t.references :game

      t.timestamps
    end
  end
end
