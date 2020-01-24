class AnswerHint < ApplicationRecord
    has_one :material_answer, foreign_key: :answer_hint_id
end
