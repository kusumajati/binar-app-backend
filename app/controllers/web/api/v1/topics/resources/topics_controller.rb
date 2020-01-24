# frozen_string_literal: true

module Web::Api::V1::Topics::Resources
  class TopicsController < Grape::API
    helpers do
      params :topic_params do
        requires :title, type: String, desc: 'Topic title',
                         documentation: { param_type: 'body' }
        optional :is_active, type: Boolean, desc: 'set topic is_active',
                             documentation: { param_type: 'body' }
        optional :chapter_id, type: String, desc: 'what chapter the topic for',
                              documentation: { param_type: 'body' }
      end
    end

    resource 'topics' do
      desc 'Get topics'
      params do
        optional :chapter_id, type: String, desc: 'ID of chapter'
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
        if permitted_params[:chapter_id].present?
          topics = Topic.select(:id, :title, :is_active)
                        .where(chapter_id: permitted_params[:chapter_id])
                        .order('updated_at DESC')
          break present result: topics
        end

        topics = Topic.select(
          :id, :title, :is_active, :chapter_id
        ).includes(:chapter).order('updated_at DESC')
        present :result, topics,
                with: Web::Api::V1::Topics::Entities::TopicIncludeChapter
      end

      desc 'Get topic by id'
      params do
        requires :id, type: String, desc: 'ID of topic'
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
        topics = Topic.select(
          :id, :title, :is_active, :chapter_id
        ).includes(:chapter).where(id: permitted_params[:id]).first
        unless topics.present?
          raise ActiveRecord::RecordNotFound, 'Topic not found'
        end

        present :result, topics,
                with: Web::Api::V1::Topics::Entities::TopicIncludeChapter
      end

      desc 'add topic'
      params do
        requires :title, type: String, desc: 'Topic title', documentation: { param_type: 'body' }
        optional :is_active, type: Boolean, desc: 'set topic is_active', documentation: { param_type: 'body' }
        requires :chapter_id, type: String, desc: 'what chapter the topic for', documentation: { param_type: 'body' }
      end
      oauth2 :admin, :academy
      post body_name: 'Topic post body', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        topic = Topic.create!(permitted_params)
        present :result, topic, with: Web::Api::V1::Topics::Entities::TopicIncludeChapter
      end

      desc 'update topic'
      params do
        requires :id, type: String, desc: 'Topic ID'
        requires :title, type: String, desc: 'Topic title', documentation: { param_type: 'body' }
        optional :is_active, type: Boolean, desc: 'set topic is_active', documentation: { param_type: 'body' }
        optional :chapter_id, type: String, desc: 'what chapter the topic for', documentation: { param_type: 'body' }
      end
      oauth2 :admin, :academy
      put ':id', body_name: 'Topic put body', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        topic = Topic.find(permitted_params[:id])
        topic.update(permitted_params)
        present :result, topic,
                with: Web::Api::V1::Topics::Entities::TopicIncludeChapter
      end

      desc 'soft delete topic'
      params do
        requires :id, type: String, desc: 'Topic ID'
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
        Topic.find(permitted_params[:id]).destroy
        nil
      end
    end
  end
end
