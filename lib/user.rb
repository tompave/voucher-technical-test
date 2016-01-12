require 'order'
require 'voucher'

class User
  attr_accessor :voucher, :orders

  def initialize(voucher = nil, orders = [])
    @voucher = voucher
    @orders = orders
  end

  def bill
    new_order = Order.new(self)

    @orders << new_order
  end
end
