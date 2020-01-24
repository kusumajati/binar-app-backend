class StudentAnswer < ApplicationRecord
    acts_as_paranoid

    belongs_to :users, optional: true, foreign_key: :student_id
    belongs_to :material_answer, optional: true, foreign_key: :student_answer_id
    belongs_to :topic, optional: true, foreign_key: :topic_id 
    belongs_to :material_question, optional: true, foreign_key: :question_id

    def self.level(user_id, question_id, topic_id, chapter_id, student_answer_id)
        total_question = MaterialQuestion.where(topic_id: topic_id).count
        total_topic = Topic.where(chapter_id: chapter_id).count

        total_question_answered = StudentAnswer.select('question_id').where(student_id: user_id, topic_id: topic_id).group(:question_id)
        total_topic_completed = StudentAnswer.select('topic_id').where(student_id: user_id, topic_id: topic_id, topic_complete: true).group(:topic_id)

        aa = total_question_answered
        bb = aa.length
        f = bb === total_question
        if f === true
           student = StudentAnswer.find(student_answer_id)
           student.update(topic_complete: true)

           cc = total_topic_completed.length
           h = cc === total_topic
                if h === true
                    stu = StudentAnswer.find(student_answer_id)
                    stu.update(chapter_complete: true)
                    level = User.find(user_id)
                    if level.level_id === 1
                    level.update(level_id: 2)
                    end
                else
                    stu = StudentAnswer.find(student_answer_id)
                    stu.update(chapter_complete: false)
                end
        else
            student = StudentAnswer.find(student_answer_id)
           student.update(topic_complete: false)
        end
        
        return student
    end

end
