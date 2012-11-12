class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer      :originating_person_id
      t.integer      :target_person_id
      t.boolean      :siblings, :default => false
      t.boolean      :adopted, :default => false
      t.timestamps
    end

    add_index :relations, :originating_person_id
    add_index :relations, :target_person_id
  end
end
