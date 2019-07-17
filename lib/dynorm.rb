# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path(__dir__))
require 'dynorm/version'

module Dynorm
  autoload :Client, 'dynorm/client'
  autoload :DbConfig, 'dynorm/db_config'
  autoload :Item, 'dynorm/item'
  autoload :ItemCollection, 'dynorm/item_collection'
  autoload :KeyExpression, 'dynorm/key_expression'
  autoload :KeyCondition, 'dynorm/key_condition'
  autoload :Query, 'dynorm/query'
end
