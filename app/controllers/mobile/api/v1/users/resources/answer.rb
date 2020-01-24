class Mobile::Api::V1::Users::Resources::Answer < Grape::API
    resource "answer" do
        desc "Quick example of Authorization", headers: {
            Authorization: {
              description: 'Validates identity through Token provided in auth/login. And please use "Bearer" prefix.',
              required: true
            }
          }
          oauth2
          params do
            optional :material_answer_id, type: Integer, documentation: {param_type: "body"}
            requires :topic_id, type: Integer, documentation: {param_type: "body"}
            requires :chapter_id, type: Integer
            requires :question_id, type: Integer
            requires :is_correct, type: Boolean
          end
        post "/answer" do
            param = params[:is_correct] === true
            answer = params[:material_answer_id].nil?
            if answer === true && param === true
              data = StudentAnswer.find_or_create_by(student_id: current_user.id, topic_id: params[:topic_id], is_correct: params[:is_correct], question_id: params[:question_id], chapter_id: params[:question_id], question_complete: true, last_success: Time.now)
              level = StudentAnswer.level(current_user.id, params[:question_id], params[:topic_id], params[:chapter_id], data.id)
      
              return level
            elsif answer === false && param === true
            data = StudentAnswer.find_or_create_by(student_id: current_user.id, topic_id: params[:topic_id], student_answer_id: params[:material_answer_id], is_correct: params[:is_correct], question_id: params[:question_id], chapter_id: params[:question_id], question_complete: true, last_success: Time.now)
            level = StudentAnswer.level(current_user.id, params[:question_id], params[:topic_id], params[:chapter_id], data.id)
      
            return level
            else
                data = StudentAnswer.find_or_create_by(student_id: current_user.id, topic_id: params[:topic_id], student_answer_id: params[:material_answer_id], is_correct: params[:is_correct], question_id: params[:question_id], chapter_id: params[:question_id])
                level = StudentAnswer.level(current_user.id, params[:question_id], params[:topic_id], params[:chapter_id], data.id)

            return level
            end
        end


        params do
            requires :user_id, type: String, documentation: {param_type: "body"}
            optional :material_answer_id, type: Integer, documentation: {param_type: "body"}
            requires :topic_id, type: Integer, documentation: {param_type: "body"}
            requires :chapter_id, type: Integer
            requires :question_id, type: Integer
            requires :is_correct, type: Boolean
          end
        post "/answer_guest" do
          binding.pry
            param = params[:is_correct] === true
            answer = params[:material_answer_id].nil?
            if answer === true && param === true
              data = StudentAnswer.find_or_create_by(student_id: params[:user_id], topic_id: params[:topic_id], is_correct: params[:is_correct], question_id: params[:question_id], chapter_id: params[:question_id], question_complete: true, last_success: Time.now)
              level = StudentAnswer.level(params[:user_id], params[:question_id], params[:topic_id], params[:chapter_id], data.id)
      
              return level
            elsif answer === false && param === true
            data = StudentAnswer.find_or_create_by(student_id: params[:user_id], topic_id: params[:topic_id], student_answer_id: params[:material_answer_id], is_correct: params[:is_correct], question_id: params[:question_id], chapter_id: params[:question_id], question_complete: true, last_success: Time.now)
            level = StudentAnswer.level(params[:user_id], params[:question_id], params[:topic_id], params[:chapter_id], data.id)
      
            return level
            else
                data = StudentAnswer.find_or_create_by(student_id: params[:user_id], topic_id: params[:topic_id], student_answer_id: params[:material_answer_id], is_correct: params[:is_correct], question_id: params[:question_id], chapter_id: params[:question_id])
                level = StudentAnswer.level(params[:user_id], params[:question_id], params[:topic_id], params[:chapter_id], data.id)

            return level
            end
        end
    end
end