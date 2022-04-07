class CreateAnimes < ActiveRecord::Migration[5.2]
  def change
    create_table :animes do |t|
      t.integer :user_id
      t.string :title, null: false
      t.text :thought, null: false
      t.text :site_url
      t.float :rate, default: 1, null: false
      t.timestamps
    end
  end
end
