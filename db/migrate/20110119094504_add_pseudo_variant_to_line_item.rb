class AddPseudoVariantToLineItem < ActiveRecord::Migration
  def self.up
    add_column :line_items, :pseudo_variant, :string
  end

  def self.down
    remove_column :line_items, :pseudo_variant
  end
end
