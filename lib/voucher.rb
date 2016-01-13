class Voucher

  class << self
    def create(type=:default, **attrs)
      klass = subclass_for(type, attrs)
      klass.new(attrs)
    end


    def subclass_for(type, attrs)
      case type
      when :default, :credit
        Vouchers::Credit
      when :discount
        if attrs[:instant]
          Vouchers::InstantDiscount
        else
          Vouchers::Discount
        end
      else
        raise "don't know Voucher type: '#{type}'."
      end
    end
  end


  def initialize(**attrs)
    extract_options(attrs)
  end


  def billing_price_for(order)
    calculate_price(order.price)
  end


  private


  def extract_options(attrs)
    @credit   = attrs[:credit]
    @discount = attrs[:discount]
    @number   = attrs[:number]
    @instant  = attrs[:instant]
  end


  def calculate_price(base_price)
    raise "not implemented, see concrete sub classes."
  end
end
