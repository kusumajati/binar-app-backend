class AddTopicIdToStudentAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :student_answers, :topic_id, :integer, foreign_key: true
  end
end
