# frozen_string_literal: true

module Web::Api::V1::Users::Entities
  class UserProfileEntity < Grape::Entity
    expose :id, expose_nil: false
    expose :gender, expose_nil: false
    expose :birth_date, format_with: :date, expose_nil: false
    expose :fullname, expose_nil: false
    expose :age, expose_nil: false
    expose :city, expose_nil: false
    expose :province, expose_nil: false
    expose :education, expose_nil: false
    expose :occupation, expose_nil: false
    expose :industry, expose_nil: false
    expose :image, expose_nil: false

    private

    def image
      return unless object.image.present?

      "#{storage_uri}/#{object.image}"
    end

    def storage_uri
      host = Configuration.get_or_default(:GCS_PUB_HOST,
                                          'https://storage.googleapis.com')
      bucket = Configuration.get_or_default(:GCS_BUCKET, ENV['GCS_BUCKET_NAME'])
      "#{host}/#{bucket}"
    end
  end
end
