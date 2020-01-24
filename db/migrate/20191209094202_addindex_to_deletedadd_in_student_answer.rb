class AddindexToDeletedaddInStudentAnswer < ActiveRecord::Migration[5.2]
  def change
    add_index :student_answers, :deleted_at
  end
end
