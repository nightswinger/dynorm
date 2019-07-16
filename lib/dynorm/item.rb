# frozen_string_literal: true

module Dynorm
  class Item
    def initialize(table_config, attrs)
      @table_config = table_config
      @attrs = attrs

      @attrs.keys.each do |key|
        self.class.define_method(key) { @attrs[key] }
      end
    end

    def update_attributes(items)
      @attrs = @attrs.merge(items)
      update_attribute_params
    end
  end
end
