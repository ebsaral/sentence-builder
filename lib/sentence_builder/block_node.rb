# This class helps to create groups of nodes to add suffix or prefix 
# EX
# Node1: Sci-fi movies
# Node2: upcoming movies 
# with this class when we group Node1 and Node 2 then it will not create Sci-fi movies upcoming movies, it will create
# as  Sci-fi upcoming movies

require 'sentence_builder/base_node'

module SentenceBuilder

  BLOCK = :block_node
  BLOCK_TYPE_PREFIX = 1
  BLOCK_TYPE_SUFFIX = 2

  class BlockNode < BaseNode
    attr_reader :name, :default, :links

    def initialize(type, options = {})
      super(BLOCK, options)
      @type = type  # BLOCK_TYPE_PREFIX or BLOCK_TYPE_SUFFIX
      @content = options[:content] || ''
      @links = []
    end

    def is_prefix?
      @type == BLOCK_TYPE_PREFIX
    end

    def is_suffix?
      @type == BLOCK_TYPE_SUFFIX
    end

    def structure(with_links=true)
      with_links ? @content : @default
    end

    def add_link(*node)
      node.each{|n| @links << n}
    end
  end
end
