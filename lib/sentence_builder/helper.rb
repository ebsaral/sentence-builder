module SentenceBuilder

  class Helper
    def self.to_boolean(value)
      if value == 'true'
        true
      elsif value == 'false'
        false
      elsif value.is_a?(TrueClass) || value.is_a?(FalseClass)
        value
      else
        false
      end
    end

    def self.is_boolean(value)
      value.is_a?(TrueClass) || value.is_a?(FalseClass)
    end
  end

end
