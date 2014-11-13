module SentenceBuilder
  class BaseNode
    attr_reader :name, :default

    def initialize(name, options = {})
      @name = name.to_sym
      @options = options
      @default = @options[:default] || nil
    end

    def prefix
      @options[:prefix] || ''
    end

    def prefix=(new_prefix)
      @options[:prefix] = new_prefix || ''
    end

    def suffix
      @options[:suffix] || ''
    end

    def suffix=(new_suffix)
      @options[:suffix] = new_suffix || ''
    end

  end
end
