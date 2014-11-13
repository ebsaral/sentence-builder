require 'active_support/core_ext/string'
require 'sentence_builder/base_node'

module SentenceBuilder

  class SentenceNode < BaseNode
    attr_reader :name, :sort_by_value, :custom_structure, :custom_structure_hash

    def initialize(name, options = {})
      super(name, options)
      @options = options
      @sort_by_value = options[:sort_by_value].to_i
      @custom_structure = options[:custom_structure] || nil
      @custom_structure_hash = options[:custom_structure_hash] || {}
    end

    def always_use
      @options[:always_use].is_a?(Boolean) ? @options[:always_use] : false
    end

    def always_use?(new_value)
      @options[:always_use] = new_value.is_a?(Boolean) ? new_value : false
    end

    def display_name
      @options[:display_name] || nil
    end

    def display_name=(new_display_name)
      @options[:display_name] = new_display_name || nil
    end

    def options
      @options[:options] || []
    end

    def options=(new_options)
      @options[:options] = new_options || []
    end

    def type
      @options[:type] || 'custom'
    end

    def type=(new_type)
      @options[:type] = new_type || 'custom'
    end

    def extra
      @options[:extra] || []
    end

    def to_hash(current_value = nil)
      {
          name: @name,
          type: type,
          always_use: always_use,
          display_name: display_name,
          default: @default,
          prefix: prefix,
          suffix: suffix,
          current_value: current_value,
          options: options,
          extra: @extra,
          sort_by_value: @sort_by_value,
          custom_structure: @custom_structure,
          custom_structure_hash: @custom_structure_hash,
          sentence: structure(current_value)
      }
    end

    def structure(value = nil)
      if value.present?
        add_prefix_and_suffix(value)
      elsif @default.present?
        add_prefix_and_suffix(@default)
      elsif @custom_structure.present? and @custom_structure.is_a?(String)
        @custom_structure % {sb_prefix: prefix,
                             sb_suffix: suffix}.merge(@custom_structure_hash)
      else
        ''
      end
    end

    private
    def add_prefix_and_suffix(value)
      [prefix, value, suffix].select(&:present?).join(' ')
    end
  end
end
