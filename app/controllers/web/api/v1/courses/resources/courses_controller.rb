# frozen_string_literal: true

module Web::Api::V1::Courses::Resources
  class CoursesController < Grape::API

    resource 'courses' do

      desc 'Get all courses'
      params do
        optional :platform_id, type: String, desc: 'platform'
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
        data = PlatformMaterial
               .select(:id, :title, :photo,
                       :description, :platform_id, :level_id)
               .includes(:platform, :level)
        if permitted_params[:platform_id].present?
          data = data.where(platform_id: permitted_params[:platform_id])
        end
        present :result, data.order('updated_at DESC'), with: Web::Api::V1::Courses::Entities::Course
      end

      desc 'get single course'
      params do
        requires :id, type: String, desc: 'Course ID'
      end
      oauth2 :admin, :academy
      get ':id', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token'],
        [404, 'Course material not found']
      ] do
        rs = PlatformMaterial
             .select(:id, :title, :photo, :description, :platform_id, :level_id)
             .includes(:platform, :level)
             .where(id: permitted_params[:id])
             .first
        if rs.blank?
          raise ActiveRecord::RecordNotFound, 'Course material not found'
        end

        present :result, rs, with: Web::Api::V1::Courses::Entities::Course
      end

      desc 'add course'
      params do
        requires :title,
                 type: String,
                 desc: 'Title of course / material',
                 documentation: { param_type: 'body' }
        requires :description,
                 type: String,
                 desc: 'Description of the course / material',
                 documentation: { param_type: 'body' }
        optional :platform_id,
                 type: String,
                 desc: 'What platform the course / material for',
                 documentation: { param_type: 'body' }
        optional :level_id,
                 type: String,
                 desc: 'What level the course / material for',
                 documentation: { param_type: 'body' }
        optional :photo,
                 type: String,
                 desc: 'photo url',
                 documentation: { param_type: 'body' }
      end
      oauth2 :admin, :academy
      post body_name: 'Course post body', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [201, 'success'],
        [401, 'Invalid Access Token']
      ] do
        data = PlatformMaterial.create!(permitted_params)
        present :result, data, with: Web::Api::V1::Courses::Entities::Course
      end

      desc 'update course'
      params do
        requires :id, type: String, desc: 'Course ID'
        requires :title,
                 type: String,
                 desc: 'Title of course / material',
                 documentation: { param_type: 'body' }
        requires :description,
                 type: String,
                 desc: 'Description of the course / material',
                 documentation: { param_type: 'body' }
        optional :platform_id,
                 type: String,
                 desc: 'What platform the course / material for',
                 documentation: { param_type: 'body' }
        optional :level_id,
                 type: String,
                 desc: 'What level the course / material for',
                 documentation: { param_type: 'body' }
        optional :photo,
                 type: String,
                 desc: 'photo url',
                 documentation: { param_type: 'body' }
      end
      oauth2 :admin, :academy
      put ':id', body_name: 'Course put body', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        course = PlatformMaterial.find(permitted_params[:id])
        course.update(permitted_params)
        present :result, course, with: Web::Api::V1::Courses::Entities::Course
      end

      desc 'soft delete course'
      params do
        requires :id, type: String, desc: 'Course ID'
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
        PlatformMaterial.find(permitted_params[:id]).destroy
        nil
      end
    end
  end
end
