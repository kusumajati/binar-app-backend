# frozen_string_literal: true

require 'google/cloud/storage'

class GcsHelper
  class << self
    def bucket(bucket_name = ENV['GCS_BUCKET_NAME'])
      @bucket ||= begin
                    storage = Google::Cloud::Storage.new(
                      project_id: ENV['GCS_PROJECT_ID'],
                      credentials: Rails.root.join(ENV['GCS_CREDENTIALS'])
                    )
                    storage.bucket bucket_name
                  end
    end
  end
end
