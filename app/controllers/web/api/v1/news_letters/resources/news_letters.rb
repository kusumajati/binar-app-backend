# frozen_string_literal: true

class Web::Api::V1::NewsLetters::Resources::NewsLetters < Grape::API
  resource "news" do
    
    #getAllNews
    desc 'get All News'
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
      if current_user.role.name != 'marketing' && current_user.role.name != 'admin'
        raise StandardError, 'Your role is not eligible'
      end
      result = News.all
      present :result, result, with: Web::Api::V1::NewsLetters::Entities::New
    end
    desc 'View News By ID'
    params do
      requires :id, type: String, desc: 'News id'
    end
    oauth2 
    get ':id', headers:{
      :Authorization => {
        description: 'Access token. Begin with Bearer',
        required: true
      }
    }, http_codes: [
      [200, 'success'],
      [401, 'Invalid Access Token']
    ] do
      result = News.find(permitted_params[:id])
      present :result, result, with: Web::Api::V1::NewsLetters::Entities::New
    end
    desc 'create News'
    params do
      requires :title, type: String, desc: 'Title of News', documentation: {param_type: "body"}
      requires :description, type: String, desc: 'Description of News', documentation: {param_type: "body"}
      requires :news_image, type: String, desc: 'image url of News', documentation: {param_type: "body"}
      requires :author, type: String, desc: 'Author who write the News', documentation: {param_type: "body"}      
    end
    oauth2
    post body_name: 'News post body', headers:{
      :Authorization => {
        description: 'Access token. Begin with Bearer',
        required: true
      }
    }, http_codes: [
      [201, 'success'],
      [401, 'Invalid Access Token']
    ] do
      if current_user.role.name != 'marketing' && current_user.role.name != 'admin'
        raise StandardError, 'Your role is not eligible'
      end
      @data = News.create({
        title: params[:title],
        description: params[:description],
        news_image: params[:news_image],
        author: params[:author],
        user_id: current_user.id
      })
      present result: {
        data: @data
      }
    end

    desc 'update News'
    params do
      requires :id, type: String, desc: 'Id from News'
      optional :title, type: String, desc: 'Title of News', documentation: {param_type: "body"}
      optional :description, type: String, desc: 'Description of News', documentation: {param_type: "body"}
      optional :news_image, type: String, desc: 'image url of News', documentation: {param_type: "body"}
      optional :author, type: String, desc: 'Author who write the News', documentation: {param_type: "body"}      
    end
    oauth2
    put ':id', body_name: 'News update body', headers:{
      :Authorization => {
        description: 'Access token. Begin with Bearer',
        required: true
      }
    }, http_codes: [
      [204, 'success'],
      [401, 'Invalid Access Token']
    ] do
      if current_user.role.name != 'marketing' && current_user.role.name != 'admin'
        raise StandardError, 'Your role is not eligible'
      end
      @data = News.where(id: permitted_params[:id]).update(permitted_params)
        {}
      present result: {
        data: @data
      } 
    end

    desc 'delete News by id'
    params do
      requires :id, type: String, desc: 'News id'
    end
    oauth2
    delete ':id', headers: {
        :Authorization => {
            description: 'Access token. Begin with Bearer',
            required: true
        }
    }, http_codes: [
        [204, 'success'],
        [401, 'Invalid Access Token']
    ] do
      if current_user.role.name != 'marketing' && current_user.role.name != 'admin'
        raise StandardError, 'Your role is not eligible'
      end
      @data = News.find(permitted_params[:id]).destroy
      {
        success:true,
        message: "deleted"
      }
    end
  end
end
