class Order
  DEFAULT_PRICE = 6.95

  attr_writer :billed_for

  # Initialize with a reference to the User and
  # the base price for the Order
  #
  def initialize(user, price=nil)
    @user = user
    @price = price
  end


  # The base price for the order.
  #
  def price
    @price || DEFAULT_PRICE
  end


  # What the Oder will actually be paid
  #
  def billed_for
    @billed_for || price
  end
end
