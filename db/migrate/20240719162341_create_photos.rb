class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.string :image
      t.float :latitude
      t.float :logitude

      t.timestamps
    end
  end
end
