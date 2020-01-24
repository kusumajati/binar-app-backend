
# frozen_string_literal: true

module Web::Api::V1::Libraries::Resources
  class LibrariesController < Grape::API
    helpers do
      params :library_params do
        optional :title, type: String, desc: 'Title', documentation: { param_type: 'body' }
        optional :description, type: String, desc: 'Description', documentation: { param_type: 'body' }
        optional :library_image, type: String, desc: 'Image', documentation: { param_type: 'body' }
        optional :library_url, type: String, desc: 'URL', documentation: { param_type: 'body' }
        optional :library_type, type: String, desc: 'Type', documentation: { param_type: 'body' }
        optional :author, type: String, desc: 'Author', documentation: { param_type: 'body' }
        optional :reading_minutes, type: String, desc: 'Reading minutes', documentation: { param_type: 'body' }
      end
    end

    resource 'libraries' do

      desc 'get all libraries'
      oauth2
      get body_name: 'News get body', headers:{
        :Authorization => {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        if current_user.role.name != 'academy' && current_user.role.name != 'admin'
          raise StandardError, 'Your role is not eligible'
        end
        result = Library.all
        present :result, result, with: Web::Api::V1::Libraries::Entities::LibraryEntity
      end

      desc 'get single library'
      params do
        requires :id, type: String, desc: 'Library ID'
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
        [404, 'library not found']
      ] do
        if current_user.role.name != 'academy' && current_user.role.name != 'admin'
          raise StandardError, 'Your role is not eligible'
        end
        data = Library.find(permitted_params[:id])
        present result: data
      end


      desc 'create library'
      params do
        use :library_params
      end
      oauth2
      post body_name: 'library post body', headers: {
        Authorization: {
          description: 'Access token, begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
          if current_user.role.name != 'academy' && current_user.role.name != 'admin'
            raise StandardError, 'Your role is not eligible'
          end
          data = Library.create!({
            title: params[:title],
            description: params[:description],
            library_image: params[:library_image],
            library_url: params[:library_url],
            library_type: params[:library_type],
            author: params[:author],
            reading_minutes: params[:reading_minutes],
            user_id: current_user.id
        })
        present result: data
      end

      desc 'update library'
      params do
        requires :id, type: Integer, desc: 'Library ID'
        use :library_params
      end
      oauth2 :admin, :academy
      put ':id', body_name: 'Library put body', headers: {
        Authorization: {
          description: 'Access token, begin with Bearer',
          required: true
        }
      }, http_codes: [
        [204, 'success'],
        [401, 'Invalid Access Token'],
        [404, 'Not found']
      ] do
        data = Library.find(permitted_params[:id])
        data.update!(permitted_params)
        present result: data
      end
      
      desc 'Delete a library'
        params do
        requires :id, type: Integer, desc: 'Library ID'
      end
      oauth2
      delete ':id', headers: {
        :Authorization => {
          description: 'Access token, begin with Bearer',
          required: true
        }
      }, http_codes: [
        [204, 'success'],
        [401, 'In
valid Access Token']
      ] do
        if current_user.role.name != 'academy' && current_user.role.name != 'admin'
          raise StandardError, 'Your role is not eligible'
        end
        Library.find(permitted_params[:id]).destroy
        {
          success:true,
          message: "deleted"
        }
      end
    end
end
end