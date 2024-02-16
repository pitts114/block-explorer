# frozen_string_literal: true

module Callable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def call(*args, &block)
      new(*args, &block).call
    end
  end

  def call
    raise NotImplementedError
  end
end
