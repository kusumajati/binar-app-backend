# frozen_string_literal: true

module Web
  module Api
    module V1
      module Roles
        module Resources
          class Roles < Grape::API
            resource :roles do
              desc 'get roles'
              # oauth2 :admin, :academy
              get headers: {
                Authorization: {
                  description: 'Access token, begin with Bearer',
                  required: true
                }
              }, http_codes: [
                [200, 'success'],
                [401, 'Invalid Access Token']
              ] do
                results = Role.all.order('updated_at DESC')
                present result: results
              end

              desc 'get by id'
              params do
                requires :id,
                         allow_blank: false,
                         type: String, desc: 'ID of Role'
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
                result = Role.find(permitted_params[:id])
                present result: result

              rescue ActiveRecord::RecordNotFound
                raise ActiveRecord::RecordNotFound, I18n.t('web.messages.data_not_found')
              end

              desc 'add role'
              params do
                requires :name,
                         type: String,
                         allow_blank: false,
                         desc: 'Name of Role',
                         documentation: { param_type: 'body' }
                requires :label,
                         type: String,
                         allow_blank: false,
                         desc: 'Label of Role',
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
                result = Role.create!(permitted_params)
                present result: result
              end

              desc 'update role'
              params do
                requires :id,
                         type: String,
                         allow_blank: false,
                         desc: 'Id of role'
                requires :name,
                         type: String,
                         allow_blank: false,
                         desc: 'Name of role',
                         documentation: { param_type: 'body' }
                requires :label,
                         type: String,
                         allow_blank: false,
                         desc: 'Label of role',
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
                role = Role.find(permitted_params[:id])
                role.update!(permitted_params)
                present result: role
              end

              desc 'remove role'
              params do
                requires :id, type: String, desc: 'Role ID'
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
                Role.find(permitted_params[:id]).destroy
                nil
              end
            end
          end
        end
      end
    end
  end
end
