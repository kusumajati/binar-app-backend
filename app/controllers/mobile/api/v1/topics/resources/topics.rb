# frozen_string_literal: true

module Mobile::Api::V1::Topics::Resources
  class Topics < Grape::API
    resource 'topics' do
      desc 'Get questions by topic'
      params do
        requires :id, type: String, desc: 'ID of topic'
      end
      get ':id/material_questions' do
        result = MaterialQuestion.where(topic_id: params[:id], is_active: true)
        present :result, result, with: Mobile::Api::V1::Topics::Entities::Question
      end
    end
  end
end
