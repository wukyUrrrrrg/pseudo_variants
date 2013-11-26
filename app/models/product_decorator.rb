Product.class_eval do
  def pseudo_options
    self.options.select {|o| o.option_type.name.starts_with? '&' }
  end
end
