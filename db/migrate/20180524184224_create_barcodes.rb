class CreateBarcodes < ActiveRecord::Migration[5.2]
  def change
    create_table :barcodes do |t|
      t.string :barcode
      t.string :symbology_type
      t.references :ingredient, foreign_key: true

      t.timestamps
    end
  end
end
