class Order
  DEFAULT_PRICE = 6.95

  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def billed_for
    price = DEFAULT_PRICE
    user.orders.each do |order|
      price - order.billed_for
    end
    price
  end
end