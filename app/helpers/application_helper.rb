module ApplicationHelper

  def real(number)
    number_to_currency(number, :unit => "R$ ", :separator => ",", :delimiter => ".")
  end
end
