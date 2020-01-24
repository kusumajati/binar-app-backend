class Mobile::Api::V1::Materials::Resources::Question  < Grape::API
    resource "question" do
      desc "Quick example of Authorization", headers: {
        Authorization: {
          description: 'Validates identity through Token provided in auth/login. And please use "Bearer" prefix.',
          required: true
        }
      }
      oauth2
            params do
                requires :topic_id, type: Integer
            end
            get "/token" do
            res = MaterialQuestion.get_question(params[:topic_id], current_user.id)
            present result: res
            end

          params do
              requires :user_id, type: String
              requires :topic_id, type: Integer
          end
          get "" do
          res = MaterialQuestion.get_question(params[:topic_id], params[:user_id])
          present result: res
          end
    end
end
