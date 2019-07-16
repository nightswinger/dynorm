# frozen_string_literal: true

module Dynorm
  class ItemCollection
    def initialize(client, items)
      @client = client
      @items  = []

      items.each do |item|
        @items << Item.new(@client, item)
      end
    end
  end
end
