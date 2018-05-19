class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :source
      t.string :directions
      t.references :cocktail, foreign_key: true

      t.timestamps
    end
  end
end
