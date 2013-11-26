# -*- coding: utf-8 -*-
Order.class_eval do
  def add_variant(variant, quantity = 1, pseudo_variant = nil)
    current_item = contains?(variant, pseudo_variant)
    if current_item
      current_item.quantity += quantity
      current_item.save
    else
      current_item = LineItem.new(:quantity => quantity)
      current_item.variant = variant
      current_item.price   = variant.price
      current_item.pseudo_variant = pseudo_variant
      self.line_items << current_item
    end

    # populate line_items attributes for additional_fields entries
    # that have populate => [:line_item]
    Variant.additional_fields.select{|f| !f[:populate].nil? && f[:populate].include?(:line_item) }.each do |field|
      value = ""

      if field[:only].nil? || field[:only].include?(:variant)
        value = variant.send(field[:name].gsub(" ", "_").downcase)
      elsif field[:only].include?(:product)
        value = variant.product.send(field[:name].gsub(" ", "_").downcase)
      end
      current_item.update_attribute(field[:name].gsub(" ", "_").downcase, value)
    end

    current_item
  end

  def contains?(variant, pseudo_variant = nil)
    line_items.detect{|line_item| line_item.variant_id == variant.id and line_item.pseudo_variant.eql? pseudo_variant}
  end
  


end
