require 'active_support/core_ext/string'
require 'sentence_builder/sentence_node'
require 'sentence_builder/helper'

module SentenceBuilder
  class Builder

    def initialize(nodes = [])
      @nodes = nodes.select{|b| b.is_a?(SentenceNode)}
    end

    # Return all nodes in order as an hashalways_use
    def get_hash(params = {}, sorted = true)
      get_nodes(sorted).map{|n| n.to_hash(params[n.name])}
    end

    # Returns the string representation of nodes and blocks by updating with given parameters
    def get_sentence(params = {}, sorted = true, separator = ' ')
      build_sentence_from_hash(get_hash(params, sorted)).select(&:present?).join(separator)
    end

    private
    # Combines array values of each element in params hash into a string with given separator
    def enhance_content(params, separator = ', ')
      params.each do |k, v|
        params[k] = if v.is_a?(Array)
                      v.join(separator)
                    else
                      params[k] = v
                    end
      end
    end

    # Return nodes by sorting option
    def get_nodes(sorted = true)
      SentenceBuilder::Helper.to_boolean(sorted) ? @nodes.sort_by{|i| i.sort_by_value} : @nodes
    end

    # By parsing each node's hash, create a sentence
    def build_sentence_from_hash(nodes)
      result = []
      nodes.each do |node|
        # This node does not appear in params
        if node[:current_value].nil?
          if node[:always_use]
            result << node[:sentence]
          end
        else
          result << node[:sentence]
        end
      end
      result
    end
  end
end