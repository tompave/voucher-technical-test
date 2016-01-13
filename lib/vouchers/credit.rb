module Vouchers
  class Credit < Voucher

    private

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

    alias_method :calculate_price, :price_from_credit
  end
end
