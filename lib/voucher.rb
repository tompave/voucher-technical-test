class Voucher
  attr_reader :type, :credit, :discount, :number, :instant

  def self.create(type=:default, **attrs)
    new(type, attrs)
  end


  def initialize(type, **attrs)
    @type = type
    extract_options(attrs)
  end


  def billing_price_for(order)
    case type
    when :default
      price_for_default(order)
    when :discount
      price_for_discount(order)
    else
      raise "don't know Voucher type: '#{type}'."
    end
  end


  private


  def extract_options(attrs)
    @credit   = attrs[:credit]
    @discount = attrs[:discount]
    @number   = attrs[:number]
    @instant  = attrs[:instant]
  end


  def price_for_default(order)
    if @credit > 0
      @credit -= order.price
      if @credit >= 0
        0.0
      else
        @credit * -1
      end
    else
      order.price
    end
  end


  def price_for_discount(order)
    order.price
  end
end
