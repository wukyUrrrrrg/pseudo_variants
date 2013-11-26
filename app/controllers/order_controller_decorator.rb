OrdersController.class_eval do
  def populate
    puts params.inspect
    @order = current_order(true)

    params[:products].each do |product_id,variant_id|
      quantity = params[:quantity].to_i if !params[:quantity].is_a?(Hash)
      quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Hash)
      @order.add_variant(Variant.find(variant_id), quantity) if quantity > 0
    end if params[:products]

    params[:variants].each do |variant_id, quantity|
      quantity = quantity.to_i
      pseudo_variant_text = params[:pseudo_variants].blank? ? nil : params[:pseudo_variants].collect {|k| k*': '}*'; '
      @order.add_variant(Variant.find(variant_id), quantity, pseudo_variant_text) if quantity > 0
    end if params[:variants]

    redirect_to cart_path
  end
end
