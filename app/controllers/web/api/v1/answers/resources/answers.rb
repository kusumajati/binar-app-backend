# frozen_string_literal: true

module Web
  module Api
    module V1
      module Answers
        module Resources
          class Answers < Grape::API
            helpers do
              params :answer_params do
                requires :answer,
                         type: String,
                         allow_blank: false,
                         desc: 'the text answer',
                         documentation: { param_type: 'body' }
                requires :is_correct,
                         type: Boolean,
                         allow_blank: false,
                         desc: 'is this the correct answer?',
                         documentation: { param_type: 'body' }
              end
            end

            resource :answers do
              desc 'get all or by question'
              params do
                optional :question_id, type: String, desc: 'ID of question'
              end
              oauth2 :admin, :academy
              get headers: {
                Authorization: {
                  description: 'Access token. start with Bearer',
                  required: true
                }
              }, http_codes: [
                [200, 'success'],
                [401, 'unauthorized']
              ] do
                if permitted_params[:question_id].present?
                  results = MaterialQuestion.all.includes(:material_answers)
                                            .order(
                                              'material_answers.updated_at DESC'
                                            )
                                            .find(
                                              permitted_params[:question_id]
                                            )
                  present :result,
                          results,
                          with: Web::Api::V1::Answers::Entities::QuestionWithAnswers
                else
                  result = MaterialAnswer.all.includes(:material_question).order('updated_at DESC')
                  present :result, result, with: Web::Api::V1::Answers::Entities::Answer
                end
              end

              desc 'add answer to question'
              params do
                requires :question_id,
                         as: :material_question_id,
                         type: String,
                         allow_blank: false,
                         desc: 'Id of the question',
                         documentation: { param_type: 'body' }
                use :answer_params
              end
              oauth2 :admin, :academy
              post headers: {
                Authorization: {
                  description: 'Access token. start with Bearer',
                  required: true
                }
              }, http_codes: [
                [201, 'success'],
                [401, 'unauthorized']
              ] do
                result = MaterialAnswer.create!(permitted_params)
                present :result, result, with: Web::Api::V1::Answers::Entities::AnswerNoQuestion
              end

              desc 'update specific answer'
              params do
                requires :id,
                         type: String,
                         allow_blank: false,
                         desc: 'Id of the answer'

                optional :question_id,
                         as: :material_question_id,
                         type: String,
                         allow_blank: false,
                         desc: 'Id of the question',
                         documentation: { param_type: 'body' }
                use :answer_params
              end
              oauth2 :admin, :academy
              put ':id', headers: {
                Authorization: {
                  description: 'Access token. start with Bearer',
                  required: true
                }
              }, http_codes: [
                [200, 'success'],
                [401, 'unauthorized']
              ] do
                result = MaterialAnswer.find(permitted_params[:id])
                result.update!(permitted_params)
                present :result, result, with: Web::Api::V1::Answers::Entities::AnswerNoQuestion
              end

              desc 'delete specific answer'
              params do
                requires :id, type: String, desc: 'Id of answer'
              end
              oauth2 :admin, :academy
              delete ':id', headers: {
                Authorization: {
                  description: 'Access token. start with Bearer',
                  required: true
                }
              }, http_codes: [
                [204, 'success'],
                [401, 'unauthorized']
              ] do
                MaterialAnswer.find(permitted_params[:id]).destroy
                nil
              end
            end
          end
        end
      end
    end
  end
end
