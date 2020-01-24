# frozen_string_literal: true

module Web::Api::V1::Users::Resources
  class ProfilesController < Grape::API
    helpers do
      params :profile_params do
        optional :gender, type: String, desc: 'User gender', documentation: { param_type: 'body' }
        optional :birth_date, type: Date, desc: 'User birth of date (e.g: 2019-12-13)', documentation: { param_type: 'body' }
        optional :fullname, type: String, desc: 'User fullname', documentation: { param_type: 'body' }
        optional :age, type: Integer, desc: 'User age', documentation: { param_type: 'body' }
        optional :city, type: String, desc: 'city', documentation: { param_type: 'body' }
        optional :province, type: String, desc: 'province', documentation: { param_type: 'body' }
        optional :education, type: String, desc: 'User education', documentation: { param_type: 'body' }
        optional :occupation, type: String, desc: 'User occupation', documentation: { param_type: 'body' }
        optional :industry, type: String, desc: 'User industry', documentation: { param_type: 'body' }
        optional :image, type: String, desc: 'User image url', documentation: { param_type: 'body' }
      end
    end

    namespace '/users/:user_id/profile' do
      desc 'update profile'
      params do
        requires :user_id, type: String, desc: 'ID of user'
        use :profile_params
      end
      oauth2 :admin, :academy, :marketing
      put body_name: 'Profile put body', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        profile = UserProfile.find_by!(user_id: permitted_params[:user_id])
        profile.update(permitted_params)
        present result: profile
      end
    end
  end
end
