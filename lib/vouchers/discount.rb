module Vouchers
  class Discount < Credit

    private

    def price_from_discount(base_price)
      if @number > 0
        @number -= 1
        discounted(base_price)
      else
        base_price
      end
    end

    alias_method :calculate_price, :price_from_discount


    def discounted(base)
      (@discount * base * 0.01).round(3)
    end
  end
end
