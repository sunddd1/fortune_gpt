class CreateFortuneTables < ActiveRecord::Migration[6.0]
  def change
    create_table :fortune_gpt_fortunes do |t|
      t.text :text, null: false

      t.timestamps
    end

    create_table :fortune_gpt_user_fortunes do |t|
      t.references :user, null: false, foreign_key: true
      t.date :picked_on, null: false
      t.references :fortune_gpt_fortune, null: false, foreign_key: { to_table: :fortune_gpt_fortunes }

      t.timestamps
    end

    add_index :fortune_gpt_user_fortunes, [:user_id, :picked_on], unique: true, name: 'idx_user_fortunes_on_user_and_picked_on'
  end
end
