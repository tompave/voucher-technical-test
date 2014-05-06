require 'user'

describe "Integration" do
  let(:user) { User.new(voucher) }

  describe 'default vouchers' do
    let(:voucher) { Voucher.new(:default, credit: 15) }

    it 'should not bill user if has a remaining credit' do
      user.bill
      expect(user.orders[0].billed_for).to eql 0
      user.bill
      expect(user.orders[1].billed_for).to eql 0
      user.bill
      expect(user.orders[2].billed_for).to eql 1.1
    end
  end

  describe 'discount vouchers' do
    context 'pay as you go' do
      let(:voucher) { Voucher.new(:discount, discount: 50, number: 3) }

      it 'should bill the right ammount' do
        user.bill
        expect(user.orders[0].billed_for).to eql 3.475
        user.bill
        expect(user.orders[1].billed_for).to eql 3.475
        user.bill
        expect(user.orders[2].billed_for).to eql 3.475
        user.bill
        expect(user.orders[3].billed_for).to eql 6.95
      end
    end

    context 'pay with first order' do
      let(:voucher) { Voucher.new(:discount, discount: 50, number: 3, instant: true) }
      it 'should be paid intantly' do
        user.bill
        expect(user.orders[0].billed_for).to eql 10.425
        user.bill
        expect(user.orders[1].billed_for).to eql 0
        user.bill
        expect(user.orders[2].billed_for).to eql 0
        user.bill
        expect(user.orders[1].billed_for).to eql 6.95
      end
    end
  end
end