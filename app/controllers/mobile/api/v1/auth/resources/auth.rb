class Mobile::Api::V1::Auth::Resources::Auth  < Grape::API
    resource "auth" do
    desc "signup"
    desc "signup"
    params do
        requires :id, type: String, documentation: {param_type: "query"}
        requires :email, type: String, documentation: {param_type: "body"}
        requires :password, type: String, documentation: {param_type: "body"}
    end
    put "/signup" do

        results =  User.find(params.id)
        data = User.find_by(email: params.email)
        unless data.blank?
        error!("Email already taken", 400)
    end
    results.update(email: params.email, password: params.password, role_id: 1)
    res = User.generate_token(params.id)
    result = {
        id: results.id,
        email: results.email,
        nickname: results.nickname,
        level: results.level.name,
        role: results.role.name,
        platform: results.platform.name,
        token: res.token
    }
    present result
    end

    params do
        requires :email, type: String, documentation: {param_type: "body"}
        requires :password, type: String, documentation: {param_type: "body"}
    end
    post "/login" do
        data = User.authenticate(params.email, params.password)
        unless data.blank?
            revoke_token = User.revoke_token(data.id)
            token = User.generate_token(data.id)
            res = {
                id: data.id,
                email: data.email,
                nickname: data.nickname,
                level: data.level.name,
                role: data.role.name,
                platform: data.platform.name,
                token: token.token
            }
            return res
        end
        error!("Wrong email or password!", 401)
    end

    desc "Quick example of Authorization", headers: {
        Authorization: {
          description: 'Validates identity through Token provided in auth/login. And please use "Bearer" prefix.',
          required: true
        }
      }
      oauth2
      get "/logout" do
        User.revoke_token(current_user.id)
        result = {
          user_id: current_user.id,
          message: "Successfully logout!"
        }
        present result
      end
end
end