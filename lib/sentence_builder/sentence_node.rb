require 'active_support/core_ext/string'
require 'sentence_builder/base_node'
require 'sentence_builder/helper'

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

    # If this is true and options is a hash with format {name: 123, value: 456, xxx: 789}
    # Then default option entered as the value in hash gets converted into its name
    def match_with_options
      SentenceBuilder::Helper.is_boolean(@options[:match_with_options]) ? @options[:match_with_options] : false
    end

    def match_with_options=(new_value)
      @options[:match_with_options] = SentenceBuilder::Helper.to_boolean(new_value)
    end

    def always_use
      SentenceBuilder::Helper.is_boolean(@options[:always_use]) ? @options[:always_use] : true
    end

    def always_use=(new_value)
      @options[:always_use] = SentenceBuilder::Helper.to_boolean(new_value)
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
        names = get_option_names(value)
        if match_with_options and names.present?
          add_prefix_and_suffix(enhance_content(names))
        else
          add_prefix_and_suffix(enhance_content(value))
        end
      elsif @default.present?
        names = get_option_names(@default)
        if match_with_options and names.present?
          add_prefix_and_suffix(enhance_content(names))
        else
          add_prefix_and_suffix(enhance_content(@default))
        end
      elsif @custom_structure.present? and @custom_structure.is_a?(String)
        @custom_structure % {sb_prefix: prefix,
                             sb_suffix: suffix}.merge(@custom_structure_hash)
      else
        ''
      end
    end

    private
    def get_option_names(value)
      options.select{|o| o[:value] == value}.map{|o| o[:name]}.uniq
    end

    def add_prefix_and_suffix(value)
      [prefix, value, suffix].select(&:present?).join(' ')
    end

    # Combines array into a string with given separator
    def enhance_content(value, separator = ', ')
      value.is_a?(Array) ? value.join(separator) : value
    end
  end
end
