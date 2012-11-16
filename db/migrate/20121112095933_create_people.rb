class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string        :name
      t.string        :gender
      t.text          :description
      t.date          :date_of_birth
      t.date          :date_of_death
      t.string        :place_of_birth
      t.string        :burial_place
      t.timestamps
    end
  end
end
