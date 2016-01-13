class Voucher
  attr_reader :type

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
      price_for_default(order.price)
    when :discount
      price_for_discount(order.price)
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


  def price_for_default(base_price)
    if @credit > 0
      @credit -= base_price
      if @credit >= 0
        0.0
      else
        @credit * -1
      end
    else
      base_price
    end
  end


  def price_for_discount(base_price)
    if @number > 0
      @number -= 1
      discounted(base_price)
    else
      base_price
    end
  end

  def discounted(base)
    (@discount * base * 0.01).round(3)
  end

    end
  end
end
