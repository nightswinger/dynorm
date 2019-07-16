# frozen_string_literal: true

require 'aws-sdk-dynamodb'

module Dynorm
  module DbConfig
    def db
      @dynamodb = Aws::DynamoDB::Client.new(region: 'ap-northeast-1')
    end

    def table_name(name)
      name = name.to_s if name.class == Symbol
      @table_config = {}
      @table_config[:table_name] = name
      self
    end

    alias table table_name

    private

    def default_params
      params = { table_name: @table_config[:table_name] }
      params
    end
  end
end
