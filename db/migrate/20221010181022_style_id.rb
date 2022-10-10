class StyleId < ActiveRecord::Migration[7.0]
  def change
    remove_column :beers, :style, :string
    add_column :beers, :style_id, :integer
  end
end
