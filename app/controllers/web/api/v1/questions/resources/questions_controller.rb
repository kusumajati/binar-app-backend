# frozen_string_literal: true

module Web
  module Api
    module V1
      module Questions
        module Resources
          class QuestionsController < Grape::API
            helpers do
              params :q_params do
                requires :question, type: Hash do
                  optional :title,
                           type: String,
                           desc: 'Question title',
                           documentation: { param_type: 'body' }
                  requires :text_question,
                           allow_blank: false,
                           type: String,
                           desc: 'Question text',
                           documentation: { param_type: 'body' }
                  requires :question_type,
                           allow_blank: false,
                           type: String,
                           values: %w[Quiz Reading],
                           default: 'Quiz',
                           desc: 'Type of question (Quiz, Reading)',
                           documentation: { param_type: 'body' }
                  requires :topic_id,
                           allow_blank: false,
                           type: String,
                           desc: 'what topic the question for',
                           documentation: { param_type: 'body' }
                  optional :is_active,
                           type: Boolean,
                           default: true,
                           desc: 'set question is_active',
                           documentation: { param_type: 'body' }
                  optional :image,
                           type: String,
                           desc: 'Image url',
                           documentation: { param_type: 'body' }
                  given question_type: ->(val) { val.eql?('Quiz') } do
                    requires :answers, type: Array[JSON], allow_blank: false do
                      optional :id, type: String, desc: 'ID of answer'
                      requires :answer,
                               allow_blank: false,
                               type: String,
                               desc: 'the text answer',
                               documentation: { param_type: 'body' }
                      optional :is_correct,
                               allow_blank: false,
                               type: Boolean,
                               default: false,
                               desc: 'is this the correct answer?',
                               documentation: { param_type: 'body' }
                      given is_correct: ->(val) { val == true } do
                        requires :appreciate_message,
                                 type: String,
                                 desc: 'message when choose correct answer'
                        optional :hint_message,
                                 type: String,
                                 desc: 'message when choose wrong answer'
                      end
                      given is_correct: ->(val) { val == false } do
                        requires :hint_message,
                                 type: String,
                                 desc: 'message when choose wrong answer'
                        optional :appreciate_message,
                                 type: String,
                                 desc: 'message when choose correct answer'
                      end
                      optional :hint_image,
                               type: String,
                               desc: 'photo url of used for hint.'
                      optional :hint_id, type: String, desc: 'ID of hint'
                    end
                  end
                end
              end
            end

            resource :questions do
              desc 'get questions'
              oauth2 :admin, :academy
              get headers: {
                Authorization: {
                  description: 'Access token. Begin with Bearer',
                  required: true
                }
              }, http_codes: [
                [204, 'success'],
                [401, 'Invalid Access Token']
              ] do
                q = MaterialQuestion.includes(
                  :material_answers, :answer_hint, :topic
                ).all

                present :result, q,
                        with: Web::Api::V1::Questions::Entities::Question
              end

              desc 'get question by id'
              params do
                requires :id, type: String, desc: 'ID of question'
              end
              oauth2 :admin, :academy
              get ':id', headers: {
                Authorization: {
                  description: 'Access token. Begin with Bearer',
                  required: true
                }
              }, http_codes: [
                [204, 'success'],
                [401, 'Invalid Access Token']
              ] do
                q = MaterialQuestion.includes(
                  :material_answers, :answer_hint, :topic
                ).find(permitted_params[:id])

                present :result, q,
                        with: Web::Api::V1::Questions::Entities::Question
              end

              desc 'add question with answers and hints'
              params do
                use :q_params
              end
              oauth2 :admin, :academy
              post '/', headers: {
                Authorization: {
                  description: 'Access token, begin with Bearer',
                  required: true
                }
              }, http_codes: [
                [201, 'created successfully'],
                [401, 'Invalid Access Token']
              ] do
                question = MaterialQuestion.create!(
                  title: permitted_params[:question][:title],
                  question: permitted_params[:question][:text_question],
                  is_active: permitted_params[:question][:is_active],
                  topic_id: permitted_params[:question][:topic_id],
                  question_image: permitted_params[:question][:image],
                  question_type: permitted_params[:question][:question_type]
                )
                if question.question_type.eql?('Quiz')
                  permitted_params[:question][:answers].each do |request|
                    AnswerHint.create!(
                      hint_message: request[:hint_message],
                      appreciate_message: request[:appreciate_message],
                      photo: request[:hint_image]
                    ).create_material_answer!(
                      answer: request[:answer],
                      is_correct: request[:is_correct],
                      material_question: question
                    )
                  end
                end

                present :result, question,
                        with: Web::Api::V1::Questions::Entities::Question
              end

              desc 'update question with answers and hints'
              params do
                use :q_params
                requires :id, type: String, desc: 'ID of the question'
              end
              oauth2 :admin, :academy
              put ':id', headers: {
                Authorization: {
                  description: 'Access token. Begin with Bearer',
                  required: true
                }
              }, http_codes: [
                [204, 'success'],
                [401, 'Invalid Access Token']
              ] do
                question = MaterialQuestion.find(permitted_params[:id])
                question.update!(
                  title: permitted_params[:question][:title],
                  question: permitted_params[:question][:text_question],
                  is_active: permitted_params[:question][:is_active],
                  topic_id: permitted_params[:question][:topic_id],
                  question_image: permitted_params[:question][:image],
                  question_type: permitted_params[:question][:question_type]
                )
                if question.question_type.eql?('Reading')
                  MaterialAnswer.where(material_question_id: question.id)
                                .destroy_all
                elsif question.question_type.eql?('Quiz')
                  permitted_params[:question][:answers].each do |request|
                    hint = AnswerHint.where(id: request[:hint_id])
                                     .first_or_initialize.tap do |h|
                      h.hint_message = request[:hint_message]
                      h.appreciate_message = request[:appreciate_message]
                      h.photo = request[:hint_image]
                      h.save
                    end
                    if hint.material_answer.present?
                      hint.material_answer.update!(
                        answer: request[:answer],
                        is_correct: request[:is_correct]
                      )
                    else
                      hint.create_material_answer!(
                        answer: request[:answer],
                        is_correct: request[:is_correct],
                        material_question: question
                      )
                    end
                  end
                end

                present :result, question,
                        with: Web::Api::V1::Questions::Entities::Question
              end

              desc 'delete question'
              params do
                requires :id, type: String, desc: 'ID of question'
              end
              oauth2 :admin, :academy
              delete ':id', headers: {
                Authorization: {
                  description: 'Access token. Begin with Bearer',
                  required: true
                }
              }, http_codes: [
                [204, 'success'],
                [401, 'Invalid Access Token']
              ] do
                MaterialQuestion.find(permitted_params[:id]).destroy
                nil
              end
            end
          end
        end
      end
    end
  end
end
