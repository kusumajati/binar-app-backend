# frozen_string_literal: true

class Utility
  class << self
    def phone_converter(number)
      phone = number.scan(/\d+/).join
      return phone.sub('0', '62') if number[0] == '0'

      phone
    end
  end
end
