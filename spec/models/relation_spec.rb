require 'spec_helper'

describe Relation do
  it { should belong_to(:originating_person).class_name('Person') }
  it { should belong_to(:target_person).class_name('Person') }

  it { should validate_presence_of :originating_person }
  it { should validate_presence_of :target_person }
end
