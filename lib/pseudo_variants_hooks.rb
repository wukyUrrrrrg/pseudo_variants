class PseudoVariantsHooks < Spree::ThemeSupport::HookListener
  insert_after :order_details_line_item_row do 
    %(
'INSERT_AFTER!'
)
  end

  replace :order_details_line_item_row do 
    %(
      <td width="300"><%= item.variant.product.name%> <%= item.pseudo_variant_text + ("(" + variant_options(item.variant) + ")" unless item.variant .option_values.empty?).to_s %></td>
      <td class="price"><%= number_to_currency item.price %></td>
      <td class="qty"><%=item.quantity%></td>
      <td class="total"><span><%= number_to_currency (item.price * item.quantity)%></span></td>)
  end


  replace :cart_item_description do 
    %(
      <h4><%= link_to variant.product.name,  product_path(variant.product) %></h4>
      <%= line_item.pseudo_variant_text + variant_options(variant) %>
      <%= truncate(Sanitize.clean(variant.product.description), :length => 100, :omission => "...")%>)
  end

  replace :admin_order_form_line_item_row do 
    %(
    <td width="300"><%= f.object.variant.product.name %> <%= f.object.pseudo_variant_text%> <%= "(" + variant_options(f.object.variant) + ")" unless f.object.variant.option_values.empty? %></td>
    <td valign="top" class="price"><%= number_to_currency f.object.price %></td>
    <td valign="top" class="qty"><%=f.text_field :quantity, :style => "width:30px;", :class => "qty" %></td>
    <td valign="top" class="total"><%= number_to_currency (f.object.price * f.object.quantity)%></td>
                                                )
  end

  protected


end
