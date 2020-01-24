class AddQuestionidandQuestionComplete < ActiveRecord::Migration[5.2]
  def change
    remove_column :material_questions, :is_complete, :boolean, default: false
    add_column :student_answers, :question_id, :integer
    add_column :student_answers, :question_complete, :boolean, default: false
    add_column :student_answers, :topic_complete, :boolean, default: false
    add_column :student_answers, :chapter_complete, :boolean, default: false
    add_column :student_answers, :chapter_id, :integer
  end
end
