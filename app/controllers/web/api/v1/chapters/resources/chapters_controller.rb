# frozen_string_literal: true

module Web::Api::V1::Chapters::Resources
  class ChaptersController < Grape::API
    resource 'chapters' do
      desc 'Get all chapters'
      params do
        optional :course_id, type: String, desc: 'course material ID'
      end
      oauth2 :admin, :academy
      get '/', headers: {
        Authorization: {
          description: 'Access token, begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        chapters = Chapter.select(:id, :name, :platform_material_id)
                          .includes(platform_material: %i[level platform])
        if permitted_params[:course_id].present?
          chapters = chapters.where(
            platform_material_id: permitted_params[:course_id]
          )
        end
        present :result, chapters.order('updated_at DESC'),
                with: Web::Api::V1::Chapters::Entities::Chapter
      end

      desc 'Get chapters by id'
      params do
        requires :id, type: String, desc: 'ID of chapter'
      end
      oauth2 :admin, :academy
      get ':id', headers: {
        Authorization: {
          description: 'Access token, begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        chapter = Chapter.select(:id, :name, :platform_material_id)
                         .includes(platform_material: %i[level platform])
                         .where(id: permitted_params[:id]).first
        if chapter.blank?
          raise ActiveRecord::RecordNotFound, 'Chapter not found'
        end

        present :result, chapter,
                with: Web::Api::V1::Chapters::Entities::Chapter
      end

      desc 'create chapter'
      params do
        requires :platform_material_id, allow_blank: false, type: String, documentation: { param_type: 'body' }
        requires :name, type: String, allow_blank: false, documentation: { param_type: 'body' }
      end
      post do
        chapter = Chapter.create!(permitted_params)
        present :result, chapter,
                with: Web::Api::V1::Chapters::Entities::Chapter
      end

      desc 'update chapter'
      params do
        requires :id, type: String, desc: 'Chapter ID'
        requires :name,
                 type: String,
                 desc: 'Chapter name',
                 documentation: { param_type: 'body' }
        optional :course_id,
                 type: String,
                 desc: 'What course the chapter for',
                 documentation: { param_type: 'body' },
                 as: :platform_material_id
      end
      oauth2 :admin, :academy
      put ':id', body_name: 'Chapter put body', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        chapter = Chapter.find(permitted_params[:id])
        chapter.update(permitted_params)
        present :result, chapter,
                with: Web::Api::V1::Chapters::Entities::Chapter
      end

      desc 'soft delete chapter'
      params do
        requires :id, type: String, desc: 'Chapter ID'
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
        Chapter.find(permitted_params[:id]).destroy
        nil
      end
    end
  end
end
