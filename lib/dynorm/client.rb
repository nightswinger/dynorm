# frozen_string_literal: true

require 'aws-sdk-dynamodb'

module Dynorm
  class Client
    class <<self
      include Query
      include DbConfig
    end
  end
end
