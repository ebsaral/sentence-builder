require "sentence_builder/builder"
require "sentence_builder/version"

module SentenceBuilder
  class << self
    # Alias for SentenceBuilder::Builder.new
    #
    # @return [SentenceBuilder::Builder]
    def new(nodes = [])
      Builder.new(nodes)
    end
  end
end
