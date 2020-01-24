class Mobile::Api::V1::Bootcamp::Resources::Bootcamp  < Grape::API
    resource "bootcamp" do
      desc "Quick example of Authorization", headers: {
        Authorization: {
          description: 'Validates identity through Token provided in auth/login. And please use "Bearer" prefix.',
          required: true
        }
      }
    oauth2
    params do
        requires :bootcamp_type, type: Boolean
    end

    post "/token" do
        result = UserProfile.where(user_id: current_user.id).first_or_create(bootcamp_type: params[:bootcamp_type])
        present result
    end

    params do
      requires :id, type: String
      requires :bootcamp_type, type: Boolean
  end
  get "/id" do
    result = UserProfile.where(user_id: params[:id]).first_or_create(bootcamp_type: params[:bootcamp_type])
    present result
  end
end
end