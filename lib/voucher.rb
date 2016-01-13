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
      price_from_credit(order.price)
    when :discount
      if @instant
        price_from_instant_discount(order.price)
      else
        price_from_discount(order.price)
      end
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


  def price_from_credit(base_price)
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


  def price_from_discount(base_price)
    if @number > 0
      @number -= 1
      discounted(base_price)
    else
      base_price
    end
  end


  def price_from_instant_discount(base_price)
    if @credit
      if @credit > 0
        price_from_credit(price_from_discount(base_price)).round(3)
      else
        base_price
      end
    else
      setup_initial_credit(base_price)
      to_be_paid_now = @credit
      charge_initial_order(base_price)
      to_be_paid_now
    end
  end


  def discounted(base)
    (@discount * base * 0.01).round(3)
  end


  def setup_initial_credit(base_price)
    @credit = begin
      this_order_price = discounted(base_price)
      assumed_remaining_price = discounted(Order::DEFAULT_PRICE) * (@number - 1)
      this_order_price + assumed_remaining_price
    end
  end


  def charge_initial_order(price)
    @credit -= discounted(price)
    @number -= 1
  end

end
