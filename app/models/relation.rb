class Relation < ActiveRecord::Base
  attr_accessible :originating_person_id, :originating_person, :target_person_id, :target_person, :relation_type, :adopted

  belongs_to :originating_person, :class_name => 'Person'
  belongs_to :target_person, :class_name => 'Person'

  validates :originating_person, :target_person, :presence => true
  validates_inclusion_of :relation_type, :in => [:parent, :spouse]
  validate :check_target_person


  private
  def check_target_person
    errors.add(:target_person, I18n.t('active_record.errors.same')) \
      if target_person && originating_person == target_person
  end
end
