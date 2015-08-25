# == Schema Information
#
# Table name: items
#
#  recipe_id            :integer
#  id                   :integer
#  name                 :string(255)
#  group                :string(255)
#  description          :text(65535)
#  sanitizedDescription :text(65535)
#  plaintext            :text(65535)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Item < ActiveRecord::Base
  has_many :item_set_blocks
  has_many :ingredients, class_name: "Item", foreign_key: "ingredient_id"
  belongs_to :recipe, class_name: "Item"
end