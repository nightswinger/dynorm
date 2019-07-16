# frozen_string_literal: true

module Dynorm
  class KeyExpression
    def initialize(attributes)
      @attributes = attributes
    end

    def attribute_names
      @attributes.keys.each_with_object({}) do |value, hash|
        hash["##{value}_name"] = value
      end
    end

    def attribute_values
      @attributes.keys.each_with_object({}) do |value, hash|
        hash[":#{value}_value"] = @attributes[value]
      end
    end

    def key_condition_expression
      @attributes.map do |attr|
        "##{attr[0]}_name = :#{attr[0]}_value"
      end.join(' and ')
    end

    def params
      {
        expression_attribute_names: attribute_names,
        expression_attribute_values: attribute_values,
        key_condition_expression: key_condition_expression
      }
    end
  end
end
