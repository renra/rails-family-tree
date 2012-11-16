require 'spec_helper'

describe Person do
  let(:person) { Person.new(:gender => :m, :name => 'John of Luxembourgh') }

  describe 'validations' do
    it { should validate_presence_of :gender }
    it { should validate_presence_of :name }

    describe 'gender' do
      it { should allow_value(:m).for(:gender) }
      it { should allow_value(:f).for(:gender) }
      it { should_not allow_value(:whatever).for(:gender) }
    end
  end

  describe 'male?, female?' do
    context 'male' do
      before { person.gender = :m }

      it { person.male?.should be true }
      it { person.female?.should be false }
    end

    context 'female' do
      before { person.gender = :f }

      it { person.male?.should be false }
      it { person.female?.should be true }
    end
  end

  describe 'relations' do
    let(:grandfather) { Person.create!(:name => 'Grand Father', :gender => :m, :date_of_birth => (Date.today - 40.years)) }
    let(:grandmother) { Person.create!(:name => 'Grand Mother', :gender => :f, :date_of_birth => (Date.today - 40.years)) }
    let(:second_grandmother) { Person.create!(:name => 'Second Grand Mother', :gender => :f, :date_of_birth => (Date.today - 40.years)) }

    let(:father) { Person.create!(:name => 'Father', :gender => :m, :date_of_birth => (Date.today - 20.years)) }
    let(:mother) { Person.create!(:name => 'Mother', :gender => :f, :date_of_birth => (Date.today - 20.years)) }

    let(:son) { Person.create!(:name => 'Son', :gender => :m, :date_of_birth => Date.today) }
    let(:daughter) { Person.create!(:name => 'Daughter', :gender => :f, :date_of_birth => Date.today) }

    before do
      Relation.create!(:originating_person => grandfather, :target_person => grandmother, :relation_type => :spouse)
      Relation.create!(:originating_person => grandfather, :target_person => second_grandmother, :relation_type => :spouse)

      Relation.create!(:originating_person => grandfather, :target_person => mother, :relation_type => :parent)
      Relation.create!(:originating_person => grandmother, :target_person => mother, :relation_type => :parent)

      Relation.create!(:originating_person => father, :target_person => mother, :relation_type => :spouse)

      Relation.create!(:originating_person => father, :target_person => son, :relation_type => :parent)
      Relation.create!(:originating_person => mother, :target_person => son, :relation_type => :parent)

      Relation.create!(:originating_person => father, :target_person => daughter, :relation_type => :parent)
      Relation.create!(:originating_person => mother, :target_person => daughter, :relation_type => :parent)
    end

    it { grandfather.parents.should == [] }
    it { grandfather.father.should == nil }
    it { grandfather.mother.should == nil }
    it { grandfather.siblings.should == [] }
    it { grandfather.brothers.should == [] }
    it { grandfather.sisters.should == [] }
    it { grandfather.spouses.should == [grandmother, second_grandmother]}
    it { grandfather.children.should == [mother] }
    it { grandfather.sons.should == [] }
    it { grandfather.daughters.should == [mother] }

    it { grandmother.parents.should == [] }
    it { grandmother.father.should == nil }
    it { grandmother.mother.should == nil }
    it { grandmother.siblings.should == [] }
    it { grandmother.brothers.should == [] }
    it { grandmother.sisters.should == [] }
    it { grandmother.spouses.should == [grandfather] }
    it { grandmother.children.should == [mother] }
    it { grandmother.sons.should == [] }
    it { grandmother.daughters.should == [mother] }

    it { second_grandmother.parents.should == [] }
    it { second_grandmother.father.should == nil }
    it { second_grandmother.mother.should == nil }
    it { second_grandmother.siblings.should == [] }
    it { second_grandmother.brothers.should == [] }
    it { second_grandmother.sisters.should == [] }
    it { second_grandmother.spouses.should == [grandfather] }
    it { second_grandmother.children.should == [] }
    it { second_grandmother.sons.should == [] }
    it { second_grandmother.daughters.should == [] }

    it { father.parents.should == [] }
    it { father.father.should == nil }
    it { father.mother.should == nil }
    it { father.siblings.should == [] }
    it { father.brothers.should == [] }
    it { father.sisters.should == [] }
    it { father.spouses.should == [mother] }
    it { father.children.should == [son, daughter] }
    it { father.sons.should == [son] }
    it { father.daughters.should == [daughter] }

    it { mother.parents.should == [grandfather, grandmother] }
    it { mother.father.should == grandfather }
    it { mother.mother.should == grandmother }
    it { mother.siblings.should == [] }
    it { mother.brothers.should == [] }
    it { mother.sisters.should == [] }
    it { mother.spouses.should == [father] }
    it { mother.children.should == [son, daughter] }
    it { mother.sons.should == [son] }
    it { mother.daughters.should == [daughter] }

    it { son.parents.should == [father, mother] }
    it { son.father.should == father }
    it { son.mother.should == mother }
    it { son.siblings.should == [daughter] }
    it { son.brothers.should == [] }
    it { son.sisters.should == [daughter] }
    it { son.spouses.should == [] }
    it { son.children.should == [] }
    it { son.sons.should == [] }
    it { son.daughters.should == [] }

    it { daughter.parents.should == [father, mother] }
    it { daughter.father.should == father }
    it { daughter.mother.should == mother }
    it { daughter.siblings.should == [son] }
    it { daughter.brothers.should == [son] }
    it { daughter.sisters.should == [] }
    it { daughter.spouses.should == [] }
    it { daughter.children.should == [] }
    it { daughter.sons.should == [] }
    it { daughter.daughters.should == [] }
  end
end
