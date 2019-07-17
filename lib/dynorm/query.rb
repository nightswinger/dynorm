# frozen_string_literal: true

module Dynorm
  module Query
    def get(key = {})
      params = default_params.merge(key: item_key(key))

      db.get_item(params)
    end

    def put(item = {})
      params = default_params.merge(item: item)
      resp = db.put_item(params)
      resp.attributes
    end

    def update(key, attrs)
      params = default_params.merge(key: item_key(key))
      params = params.merge(attribute_updates: update_attribute_params(attrs))

      db.update_item(params)
    end

    def remove_attributes(key, *attrs)
      params = default_params.merge(key: item_key(key))
      params = params.merge(attribute_updates: remove_attribute_params(attrs))

      db.update_item(params)
    end

    def query_v2(key, options = {})
      conditions = KeyCondition.new key

      params = default_params.merge(conditions.params)
      params = params.merge(option_params(options)) if options.any?

      puts params

      db.query(params)
    end

    def query(key, options = {})
      exp = KeyExpression.new(key)

      params = default_params.merge(exp.params)
      params = params.merge(option_params(options)) if options.any?

      db.query(params)
    end

    def find(hash = {})
      resp = query(hash)
      Item.new @table_config, resp.items.first
    end

    def where(key, options = {})
      resp = query(key, options)
      ItemCollection.new @table_config, resp.items
    end

    private

    def option_params(args)
      args[:index_name] = args[:index] if args.keys.include?(:index)
      args.delete(:index)
      args
    end

    def item_key(key = {})
      params = { key.keys.first => key[key.keys.first] }
      params = params.merge(key.keys.last => key[key.keys.last]) if key.length != 1
      params
    end

    def update_attribute_params(attrs, action = 'PUT')
      attrs.keys.each_with_object({}) do |key, params|
        params[key] = { value: attrs[key], action: action }
      end
    end

    def remove_attribute_params(keys, action = 'DELETE')
      keys.each_with_object({}) do |key, params|
        params[key] = { action: action }
      end
    end
  end
end
