class CreateStudentAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :student_answers do |t|
      t.boolean :is_correct
      t.integer :student_answer_id
      t.uuid :student_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
