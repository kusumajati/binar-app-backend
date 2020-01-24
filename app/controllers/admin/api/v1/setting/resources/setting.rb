# frozen_string_literal: true

class Admin::Api::V1::Setting::Resources::Setting < Grape::API
  resource 'setting' do
    desc 'Get Configuration'
    get '/' do
      results = Configuration.all
      present :setting, results
    end

    desc 'update Configuration'
    params do
      requires :setting, type: Array do
        requires :key, type: String
        requires :value, type: String
      end
    end
    put '/' do
      params.setting.each { |x| Configuration.find_by_key(x[:key]).try(:update, value: x[:value]) }
      results = Configuration.all
      ActivityLog.write('Update Configuration', request, current_user)
      present :setting, results
    end
  end
end
