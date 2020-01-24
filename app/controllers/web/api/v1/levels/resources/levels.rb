# frozen_string_literal: true

module Web
  module Api
    module V1
      module Levels
        module Resources
          class Levels < Grape::API
            resource :levels do
              desc 'get levels'
              oauth2 :admin, :academy
              get headers: {
                Authorization: {
                  description: 'Access token, begin with Bearer',
                  required: true
                }
              }, http_codes: [
                [200, 'success'],
                [401, 'Invalid Access Token']
              ] do
                results = Level.all.order('updated_at DESC')
                present result: results
              end

              desc 'get by id'
              params do
                requires :id,
                         allow_blank: false,
                         type: String, desc: 'ID of Level'
              end
              # oauth2 :admin, :academy
              get ':id', headers: {
                Authorization: {
                  description: 'Access token, begin with Bearer',
                  required: true
                }
              }, http_codes: [
                [200, 'success'],
                [401, 'Invalid Access Token']
              ] do
                result = Level.find(permitted_params[:id])
                present result: result

              rescue ActiveRecord::RecordNotFound
                raise ActiveRecord::RecordNotFound, I18n.t('web.messages.data_not_found')
              end

              desc 'add level'
              params do
                requires :name,
                         type: String,
                         allow_blank: false,
                         desc: 'Name of Level',
                         documentation: { param_type: 'body' }
              end
              # oauth2 :admin, :academy
              post headers: {
                Authorization: {
                  description: 'Access token, begin with Bearer',
                  required: true
                }
              }, http_codes: [
                [201, 'success'],
                [401, 'Invalid Access Token']
              ] do
                result = Level.create!(permitted_params)
                present result: result
              end

              desc 'update level'
              params do
                requires :id,
                         type: String,
                         allow_blank: false,
                         desc: 'Id of level'
                requires :name,
                         type: String,
                         allow_blank: false,
                         desc: 'Name of Level',
                         documentation: { param_type: 'body' }
              end
              # oauth2 :admin, :academy
              put ':id', headers: {
                Authorization: {
                  description: 'Access token, begin with Bearer',
                  required: true
                }
              }, http_codes: [
                [200, 'success'],
                [401, 'Invalid Access Token']
              ] do
                level = Level.find(permitted_params[:id])
                level.update!(permitted_params)
                present result: level
              end

              desc 'remove level'
              params do
                requires :id, type: String, desc: 'Level ID'
              end
              # oauth2 :admin, :academy, :marketing
              delete ':id', headers: {
                Authorization: {
                  description: 'Access token. Begin with Bearer',
                  required: true
                }
              }, http_codes: [
                [204, 'success'],
                [401, 'Invalid Access Token']
              ] do
                Level.find(permitted_params[:id]).destroy
                nil
              end
            end
          end
        end
      end
    end
  end
end
