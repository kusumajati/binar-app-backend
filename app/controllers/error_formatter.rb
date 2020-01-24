# frozen_string_literal: true

module ErrorFormatter
  def self.call(message, _backtrace, _options, env, _original_exception)
    {
        status: false,
        code: 400,
        message: message
    }.to_json
  end
end
