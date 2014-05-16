class Voucher
  attr_accessor :credit, :type

  def self.create(type, *attrs)
  end

  def billed_for
    Random.new.rand(0..4)
  end
end