module OrdersHelper
  def number_to_euro(price)
    number_to_currency(price.to_f, unit: "€", format: "%n %u")
  end

  def decoration_string(len)
    my_string = ""
    (0...len).each {|n| my_string += ('a'..'z').to_a.sample }
    my_string
  end
end
