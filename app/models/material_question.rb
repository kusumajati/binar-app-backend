# frozen_string_literal: true

class MaterialQuestion < ApplicationRecord
  acts_as_paranoid

  belongs_to :topic, optional: true
  has_many :material_answers, dependent: :destroy
  has_many :answer_hint, through: :material_answers

  validates_presence_of :question
  validates_inclusion_of :question_type, in: %w[Quiz Reading]

  def self.get_question(topic_id, user_id)
    data = MaterialQuestion.where(topic_id: topic_id)
            aa = []
            data.each do |f|
                ans = f.material_answers
                cc = StudentAnswer.find_by(student_id: user_id, question_id: f.id)
                aac = cc.question_complete rescue nil
                aned = []
                ans.each do |e|
                    lala = e.answer_hint
                    results = {
                        id: e.id,
                        answer: e.answer,
                        is_correct: e.is_correct,
                        hints: lala
                    }
                    aned << results
                end
                ress = {
                    id: f.id,
                    question: f.question,
                    is_complete: aac,
                    question_type: f.question_type,
                    question_image: f.question_image,
                    answers: aned
                }
                aa << ress
            end
            topics = Topic.find(topic_id)

            res = {
                topic_titte: topics.title,
                total_question: MaterialQuestion.where(topic_id: topic_id).count,
                questions: aa
            }
            return res
  end
end
