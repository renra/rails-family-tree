class Relation < ActiveRecord::Base
  attr_accessible :originating_person_id, :target_person_id, :siblings, :adopted

  belongs_to :originating_person, :class_name => 'Person'
  belongs_to :target_person, :class_name => 'Person'

  validates :originating_person, :target_person, :presence => true
end
