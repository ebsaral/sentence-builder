require 'active_support/core_ext/string'
require 'sentence_builder/base_node'

module SentenceBuilder

  class SentenceNode < BaseNode
    attr_reader :name, :sort_by_value

    def initialize(name, options = {})
      super(name, options)
      @prefix = options[:prefix] || ''
      @suffix = options[:suffix] || ''
      @options = options[:options]
      @type = options[:type] || 'custom'
      @display_name = options[:display_name] || nil
      @extra = options[:extra] || []
      @custom_structure = options[:custom_structure] || nil
      @sort_by_value = options[:sort_by_value] || 0
    end

    def to_hash(value = nil)
      sentence_value = (value.nil?) ? @default : value
      {
          # Basic
          node: 'sentence',
          name: @name,
          type: @type,  # 'custom', 'text', 'text_input', 'dropdown'
          display_name: @display_name,
          default: @default,
          # Populated
          structure: structure,
          sentence: structure % {@name => sentence_value},
          current_value: value,
          # Extra
          options: @options,
          extra: @extra
      }
    end

    # "my prefix %{#name} is working with my suffix" % {name: 'test'}
    def structure(without_default=true)
      if @custom_structure.present?
        @custom_structure
      else
        if without_default
          @prefix + "%{#{@name}}" + @suffix
        else
          @prefix + @default + @suffix
        end
      end
    end

  end
end
