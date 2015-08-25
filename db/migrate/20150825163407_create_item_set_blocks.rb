class CreateItemSetBlocks < ActiveRecord::Migration
  def change
    create_table :item_set_blocks do |t|
      t.belongs_to :item_set, index: true
      t.belongs_to :item, index: true

      t.string :type
      t.boolean :recMath
      t.integer :minSummonerLevel
      t.integer :maxSummonerLevel
      t.string :showIfSummonerSpell
      t.string :hideIfSummonerSpell

      t.timestamps null: false
    end
  end
end