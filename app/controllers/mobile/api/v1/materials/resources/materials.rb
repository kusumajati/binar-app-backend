# frozen_string_literal: true

module Mobile::Api::V1::Materials::Resources
  class Materials < Grape::API
    resource 'platform_materials' do
      
      
      params do
        requires :user_id, type: String, documentation: {param_type: "query"}
        end
      get '' do
        data = User.find(params[:user_id])
        res = PlatformMaterial.get_material(params[:user_id], data.level_id, data.platform_id)
        present res
      end
    end
  end
end
