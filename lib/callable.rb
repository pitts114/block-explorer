module Callable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def call(**kwargs, &block)
      new.call(**kwargs, &block)
    end
  end

  def call(**kwargs)
    raise NotImplementedError, "Subclasses must implement the 'call' method"
  end
end
