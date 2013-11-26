LineItem.class_eval do
  def pseudo_variant_text
    (("<strong>" + self.pseudo_variant + "</strong>; ").html_safe unless self.pseudo_variant.blank?).to_s
  end
end
