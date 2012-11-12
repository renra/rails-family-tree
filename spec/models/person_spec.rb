require 'spec_helper'

describe Person do
  describe 'validations' do
    it { should validate_presence_of :gender }
    it { should validate_presence_of :name }

    describe 'orientation_date' do
      let(:person) { Person.new(:gender => :m, :name => 'John of Luxembourgh') }
      subject { person.valid?; person.errors[:orientation_date] }

      context 'date of birth not supplied' do
        it { should == ["can't be blank"] }
      end

      context 'date of birth is supplied' do
        before { person.date_of_birth = Date.today }
        it { should == [] }
      end
    end
  end
end
