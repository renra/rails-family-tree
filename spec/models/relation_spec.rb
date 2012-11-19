require 'spec_helper'

describe Relation do
  it { should belong_to(:originating_person).class_name('Person') }
  it { should belong_to(:target_person).class_name('Person') }

  describe 'validations' do
    it { should validate_presence_of :relation_type }
    it { should validate_presence_of :originating_person }
    it { should validate_presence_of :target_person }

    it 'should not allow relations of one person' do
      person = Person.new
      relation = Relation.new(:originating_person => person, :target_person => person)

      relation.valid?
      relation.errors[:target_person].should == ['cannot be the same']
    end

    it { should allow_value(:parent).for(:relation_type) }
    it { should allow_value(:spouse).for(:relation_type) }
    it { should_not allow_value(:sibling).for(:relation_type) }
    it { should_not allow_value(:whatever).for(:relation_type) }
  end
end
