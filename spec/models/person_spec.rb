require 'spec_helper'

describe Person do
  let(:person) { Person.new(:gender => :m, :name => 'John of Luxembourgh') }

  describe 'validations' do
    it { should validate_presence_of :gender }
    it { should validate_presence_of :name }

    describe 'orientation_date' do
      subject { person.valid?; person.errors[:orientation_date] }

      context 'date of birth not supplied' do
        it { should == ["can't be blank"] }
      end

      context 'date of birth is supplied' do
        before { person.date_of_birth = Date.today }
        it { should == [] }
      end
    end

    describe 'gender' do
      it { should allow_value(:m).for(:gender) }
      it { should allow_value(:f).for(:gender) }
      it { should_not allow_value(:whatever).for(:gender) }
    end
  end

  describe 'relations' do
    let(:grandfather) { Person.new(:name => 'Grand Father', :gender => :m, :date_of_birth => (Date.today - 40.years) }
    let(:grandmother) { Person.new(:name => 'Grand Mother', :gender => :f, :date_of_birth => (Date.today - 40.years) }


    let(:father) { Person.new(:name => 'Father', :gender => :m, :date_of_birth => (Date.today - 20.years) }
    let(:mother) { Person.new(:name => 'Mother', :gender => :f, :date_of_birth => (Date.today - 20.years) }

    let(:son) { Person.new(:name => 'Son', :gender => :m, :date_of_birth => Date.today }
    let(:daughter) { Person.new(:name => 'Daughter', :gender => :f, :date_of_birth => Date.today }
    # ...
  end
end
