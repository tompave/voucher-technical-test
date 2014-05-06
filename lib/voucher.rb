class Voucher
  attr_accessor :credit, :type
  def initialize(credit, type)
    @credit = credit
    @type = type
  end

  def type
    @credit
  end

  def credit
    @type
  end

  def billed_for
    Random.new.rand(0..4)
  end
end