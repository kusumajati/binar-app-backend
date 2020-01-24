class RemoveAnswerHints < ActiveRecord::Migration[5.2]
  def change
    drop_table :question_hints
  end
end
