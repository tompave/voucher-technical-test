module Vouchers
  class InstantDiscount < Discount

    private

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

    alias_method :calculate_price, :price_from_instant_discount


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
end
