class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.string :a
      t.string :b
      t.string :c

      t.timestamps
    end
  end
end
