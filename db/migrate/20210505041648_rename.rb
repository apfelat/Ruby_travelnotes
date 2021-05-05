class Rename < ActiveRecord::Migration[5.2]
  def change
     rename_column :posts, :image, :picture
  end
end
