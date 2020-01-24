class CreateBootcamps < ActiveRecord::Migration[5.2]
  def change
    create_table :bootcamps do |t|
      t.string :name
      t.text :description
      t.string :academy_image
      t.string :location
      t.datetime :start_bootcamp
      t.datetime :end_bootcamp
      t.string :bootcamp_duration
      t.string :minimum_attendace
      t.datetime :class_duration
      t.datetime :start_class
      t.datetime :start_class_time
      t.datetime :end_class_time
      t.boolean :bootcamp_type
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
