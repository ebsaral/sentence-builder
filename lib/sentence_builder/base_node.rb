module SentenceBuilder
  class BaseNode
    attr_reader :name, :default

    def initialize(name, options = {})
      @name = name.to_sym

      @default = options[:default] || ''
    end

    def is_block?
      self.is_a?(BlockNode) ? true : false
    end

    def structure
      @prefix + "%{#{@name}}" + @suffix
    end
  end
end
