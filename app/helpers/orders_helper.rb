module OrdersHelper
  def decoration_string(len)
    my_string = ""
    (0...len).each {|n| my_string += ('a'..'z').to_a.sample }
    my_string
  end
end
