class CreateAnimes < ActiveRecord::Migration[5.2]
  def change
    create_table :animes do |t|
      t.integer :user_id
      t.string :title
      t.text :thought
      t.string :anime_image_id

      t.timestamps
    end
  end
end
