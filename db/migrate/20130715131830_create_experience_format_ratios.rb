class CreateExperienceFormatRatios < ActiveRecord::Migration
  def change
    create_table :experience_format_ratios do |t|
      t.references :format,           null: false
      t.integer    :outer_format_id,  null: false
      t.float      :ratio,            null: false, default: 0.1
    end

    add_index :experience_format_ratios, [:outer_format_id, :format_id], unique: true
  end
end
