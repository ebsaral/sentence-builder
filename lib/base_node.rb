module Builder
  class BaseNode
    attr_reader :name, :default

    def initialize(name, options = {})
      @name = name.to_sym

      @default = options[:default] || ''
    end

    def is_block?
      self.is_a?(Filters::BlockNode) ? true : false
    end

    def structure
      @prefix + "%{#{@name}}" + @suffix
    end
  end
end
