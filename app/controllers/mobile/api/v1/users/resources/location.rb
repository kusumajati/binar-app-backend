class Mobile::Api::V1::Users::Resources::Location < Grape::API
    resource "location" do
        get "/province" do
            data = Province.select('id', 'name')
            present result: data
        end
        
        params do
            requires :province_id, type: Integer
        end
        get "" do
            data = Regency.select('id','name').where(province_id: params[:province_id])
            present result: data
        end
    end
end