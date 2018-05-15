class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.references :cocktail, foreign_key: true
      t.string :source
      t.string :directions

      t.timestamps
    end
  end
end
