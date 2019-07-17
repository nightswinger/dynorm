# frozen_string_literal: true

module Dynorm
  class KeyCondition
    def initialize(keys)
      @attributes = keys
    end

    def params
      { key_conditions: key_conditions }
    end

    def key_conditions
      @attributes.keys.each_with_object({}) do |key, hash|
        value = @attributes[key]

        operator = key.to_s.include?('.') ? key.to_s.split('.').last.upcase : 'EQ'
        key = key.to_s.split('.').first if key.to_s.include?('.')

        hash[key] = {
          attribute_value_list: [value],
          comparison_operator: operator
        }
      end
    end
  end
end
