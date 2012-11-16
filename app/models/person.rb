class Person < ActiveRecord::Base
  attr_accessible :name, :date_of_birth, :date_of_death, :gender, :description, :place_of_birth, :burial_place

  validates_presence_of :name, :gender

  validates_inclusion_of :gender, :in => [:m, :f]

  def male?
    gender.to_s == 'm'
  end

  def female?
    gender.to_s == 'f'
  end

  def parents
    Relation.where(:target_person_id => id, :relation_type => :parent).map(&:originating_person)
  end

  def father
    find_first_by_method(parents, :male?)
  end

  def mother
    find_first_by_method(parents, :female?)
  end

  def siblings
    parents.map(&:children).flatten.uniq.reject{|child| child == self }
  end

  def brothers
    find_by_method(siblings, :male?)
  end

  def sisters
    find_by_method(siblings, :female?)
  end

  def spouses
    Relation.where(:originating_person_id => id, :relation_type => :spouse).map(&:target_person).concat(
      Relation.where(:target_person_id => id, :relation_type => :spouse).map(&:originating_person)
    )
  end

  def children
    Relation.where(:originating_person_id => id, :relation_type => :parent).map(&:target_person)
  end

  def sons
    find_by_method(children, :male?)
  end

  def daughters
    find_by_method(children, :female?)
  end

  private
  def find_first_by_method(haystack, method)
    find_by_method(haystack, method).first
  end

  def find_by_method(haystack, method)
    haystack.find_all{|straw| straw.send(method) }
  end
end
