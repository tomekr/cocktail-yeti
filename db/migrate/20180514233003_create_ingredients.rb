class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.references :recipe, foreign_key: true
      t.string :name
      t.string :generic_name
      t.string :ingredient_use
      t.string :amount

      t.timestamps
    end
  end
end
