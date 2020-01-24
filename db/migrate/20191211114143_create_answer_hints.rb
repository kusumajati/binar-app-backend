class CreateAnswerHints < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_hints do |t|
      t.text :hint_message
      t.text :appreciate_message
      t.string :photo

      t.timestamps
    end
  end
end
