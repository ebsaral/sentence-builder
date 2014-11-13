require "sentence_builder/builder"
require "sentence_builder/version"

module SentenceBuilder
  def self.builder(nodes = [])
    Builder.new(nodes)
  end
end
