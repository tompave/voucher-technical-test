class Voucher
  attr_reader :type, :credit, :discount, :number, :instant

  def self.create(type=:default, **attrs)
    new(type, attrs)
  end


  def initialize(type, **attrs)
    @type     = type
    @credit   = attrs[:credit]
    @discount = attrs[:discount]
    @number   = attrs[:number]
    @instant  = attrs[:instant]
  end

  def billed_for
    Random.new.rand(0..4)
  end
end
