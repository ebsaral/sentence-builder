require 'active_support/core_ext/string'
require 'sentence_builder/block_node'
require 'sentence_builder/sentence_node'

module SentenceBuilder
  class Builder

    def initialize(nodes = [], blocks = [], sorted = true)
      @nodes = nodes.select{|b| b.is_a?(SentenceNode)}
      @blocks = blocks.select{|b| b.is_a?(BlockNode)}
      @sorted = sorted
    end

    # Returns the string representation of nodes and blocks by updating with given parameters
    def get_sentence(params = {}, enhance = true, separator = ' ')
      hash = (enhance ? enhance_content(params) : params)
      build_sentence_from_params(params).join(separator) % hash
    end

    # Return all nodes in order as an hash
    def get_hash(params = {})
      get_nodes.map{|n| n.to_hash(params[n.name])}
    end

    private
    def get_node_by_name(name)
      nodes.select{|n| n.name == name}.first
    end

    def enhance_content(params)
      params.each do |k, v|
        params[k] = if v.is_a?(Array)
                      v.join(', ')
                    else
                      params[k] = v.to_s
                    end
      end
    end

    def add_node(node)
      @nodes << node
    end

    def get_nodes
      if @sorted
        @nodes.sort_by{|i| i.sort_by_value}
      else
        @nodes
      end
    end

    def combine_nodes
      result = Array.new(get_nodes)
      @blocks.each do |b|
        matches = result.select{|n| b.links.include?(n.name)}
        if matches.present?
          if b.is_prefix?
            result.insert(result.index(matches.first), b)
          elsif b.is_suffix?
            result.insert(result.index(matches.last) + 1, b)
          end
        end
      end
      result
    end

    def build_sentence_from_params(params)
      result = []

      combine_nodes.each do |node|
        if node.is_block?
          if (node.links & params.keys).size == 0
            result << node.structure(false)
          else
            result << node.structure(true)
          end
        elsif params.has_key?(node.name)
          result << node.structure(true)
        else
          result << node.structure(false)
        end
      end
      result.select(&:present?)
    end
  end
end