module ProductsHelper
  def show_is_active(is_active)
    return "Active" if is_active
    "Inactive"
  end

  def discount_price(price, discount)
    d = (discount / 100) * price
    discount_price = price - d

    number_to_currency(discount_price, unit: "Rp. ")
  end
end
