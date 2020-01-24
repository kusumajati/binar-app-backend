class AddLastUpdateToStudentAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :student_answers, :last_success, :datetime
  end
end
