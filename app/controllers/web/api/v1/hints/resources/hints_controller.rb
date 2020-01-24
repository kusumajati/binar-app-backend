<<<<<<< HEAD
# frozen_string_literal: true

module Web::Api::V1::Hints::Resources
  class HintsController < Grape::API
    resource 'hints' do
      desc 'Get all hints (just provide question_id query param to get hint by question)'
      params do
        optional :question_id, type: String, desc: 'ID of Question'
      end
      oauth2
      get '/', headers: {
        Authorization: {
          description: 'Access token, begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        if permitted_params[:question_id].present?
          rs = QuestionHint.select(:id, :hint_message, :appreciate_message)
                           .where(material_question_id: permitted_params[:question_id]).first!
          present result: rs
        else
          rs = QuestionHint
               .select(:id, :hint_message, :appreciate_message, :material_question_id).includes(:material_question)
          present :result, rs, with: Web::Api::V1::Hints::Entities::HintIncludeQuestion
        end
      end

      desc 'get single hint by id'
      params do
        requires :id, type: String, desc: 'hint ID'
      end
      oauth2
      get ':id', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token'],
        [404, 'hint not found']
      ] do
        rs = QuestionHint.select(:id, :hint_message, :appreciate_message, :material_question_id)
                         .includes(:material_question).where(id: permitted_params[:id]).first
        raise ActiveRecord::RecordNotFound, 'Hint not found' if rs.nil?

        present :result, rs, with: Web::Api::V1::Hints::Entities::HintIncludeQuestion
      end

      desc 'add hint for a question'
      params do
        requires :hint_message, type: String, desc: 'The message if student choose wrong answer', documentation: { param_type: 'body' }
        requires :appreciate_message, type: String, desc: 'The message if student choose correct answer', documentation: { param_type: 'body' }
        requires :question_id, type: String, desc: 'Which question the hint for', documentation: { param_type: 'body' }, as: :material_question_id
      end
      oauth2
      post body_name: 'Hint post body', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        rs = QuestionHint.create!(permitted_params)
        present result: {
          id: rs.id
        }
      end

      desc 'update hint'
      params do
        requires :id, type: String, desc: 'Hint ID'
        requires :hint_message, type: String, desc: 'The message if student choose wrong answer', documentation: { param_type: 'body' }
        requires :appreciate_message, type: String, desc: 'The message if student choose correct answer', documentation: { param_type: 'body' }
        optional :question_id, type: String, desc: 'Which question the hint for', documentation: { param_type: 'body' }, as: :material_question_id
      end
      oauth2
      put ':id', body_name: 'hint put body', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        QuestionHint.where(id: permitted_params[:id]).update(permitted_params)
        {}
      end

      desc 'delete hint'
      params do
        requires :id, type: String, desc: 'Hint ID'
      end
      oauth2
      delete ':id', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [204, 'success'],
        [401, 'Invalid Access Token']
      ] do
        QuestionHint.find(permitted_params[:id]).destroy
        {}
        present result: {
          data: @data
        }
      end
    end
  end
end
=======
# # frozen_string_literal: true
#
# module Web::Api::V1::Hints::Resources
#   class HintsController < Grape::API
#
#     resource 'hints' do
#       desc 'Get all hints'
#       params do
#         optional :question_id,
#                  type: String,
#                  desc: 'ID of Question, to find hints by question'
#       end
#       oauth2 :admin, :academy
#       get '/', headers: {
#         Authorization: {
#           description: 'Access token, begin with Bearer',
#           required: true
#         }
#       }, http_codes: [
#         [200, 'success'],
#         [401, 'Invalid Access Token']
#       ] do
#         if permitted_params[:question_id].present?
#           rs = QuestionHint
#                .select(:id, :hint_message, :appreciate_message)
#                .where(material_question_id: permitted_params[:question_id])
#                .first!
#           present result: rs
#         else
#           rs = QuestionHint
#                .select(
#                  :id, :hint_message, :appreciate_message, :material_question_id
#                ).includes(:material_question)
#           present :result, rs,
#                   with: Web::Api::V1::Hints::Entities::HintIncludeQuestion
#         end
#       end
#
#       desc 'get single hint by id'
#       params do
#         requires :id, type: String, desc: 'hint ID'
#       end
#       oauth2 :admin, :academy
#       get ':id', headers: {
#         Authorization: {
#           description: 'Access token. Begin with Bearer',
#           required: true
#         }
#       }, http_codes: [
#         [200, 'success'],
#         [401, 'Invalid Access Token'],
#         [404, 'hint not found']
#       ] do
#         rs = QuestionHint
#              .select(
#                :id, :hint_message, :appreciate_message, :material_question_id
#              ).includes(:material_question).where(id: permitted_params[:id])
#              .first
#         raise ActiveRecord::RecordNotFound, 'Hint not found' if rs.nil?
#
#         present :result, rs,
#                 with: Web::Api::V1::Hints::Entities::HintIncludeQuestion
#       end
#
#       desc 'add hint for a question'
#       params do
#         requires :hint_message,
#                  type: String,
#                  desc: 'The message if student choose wrong answer',
#                  documentation: { param_type: 'body' }
#         requires :appreciate_message,
#                  type: String,
#                  desc: 'The message if student choose correct answer',
#                  documentation: { param_type: 'body' }
#         requires :question_id,
#                  type: String,
#                  desc: 'Which question the hint for',
#                  documentation: { param_type: 'body' },
#                  as: :material_question_id
#       end
#       oauth2 :admin, :academy
#       post body_name: 'Hint post body', headers: {
#         Authorization: {
#           description: 'Access token. Begin with Bearer',
#           required: true
#         }
#       }, http_codes: [
#         [200, 'success'],
#         [401, 'Invalid Access Token']
#       ] do
#         rs = QuestionHint.create!(permitted_params)
#         present :result, rs,
#                 with: Web::Api::V1::Hints::Entities::HintIncludeQuestion
#       end
#
#       desc 'update hint'
#       params do
#         requires :id, type: String, desc: 'Hint ID'
#         requires :hint_message,
#                  type: String,
#                  desc: 'The message if student choose wrong answer',
#                  documentation: { param_type: 'body' }
#         requires :appreciate_message,
#                  type: String,
#                  desc: 'The message if student choose correct answer',
#                  documentation: { param_type: 'body' }
#         optional :question_id,
#                  type: String,
#                  desc: 'Which question the hint for',
#                  documentation: { param_type: 'body' },
#                  as: :material_question_id
#       end
#       oauth2 :admin, :academy
#       put ':id', body_name: 'hint put body', headers: {
#         Authorization: {
#           description: 'Access token. Begin with Bearer',
#           required: true
#         }
#       }, http_codes: [
#         [200, 'success'],
#         [401, 'Invalid Access Token']
#       ] do
#         hint = QuestionHint.find(permitted_params[:id])
#         hint.update(permitted_params)
#         present :result, hint,
#                 with: Web::Api::V1::Hints::Entities::HintIncludeQuestion
#       end
#
#       desc 'delete hint'
#       params do
#         requires :id, type: String, desc: 'Hint ID'
#       end
#       oauth2 :admin, :academy
#       delete ':id', headers: {
#         Authorization: {
#           description: 'Access token. Begin with Bearer',
#           required: true
#         }
#       }, http_codes: [
#         [204, 'success'],
#         [401, 'Invalid Access Token']
#       ] do
#         QuestionHint.find(permitted_params[:id]).destroy
#         nil
#       end
#     end
#   end
# end
>>>>>>> 39452e8aba143279eff8a1f3d9e0bb62d4346cf1
