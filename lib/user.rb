require 'order'
require 'voucher'

class User
  attr_accessor :voucher, :orders

  def initialize(voucher = nil, orders = [])
    @voucher = voucher
    @orders = orders
  end


  def bill(order_price=nil)
    new_order = Order.new(self, order_price)

    if voucher
      new_order.billed_for = voucher.billing_price_for(new_order)
    end

    @orders << new_order
  end
end
