require 'spec_helper'

describe SentenceBuilder::BaseNode do

  let (:name) { :test }
  let (:name_string) { 'test' }

  describe "#new" do

    context "without extra parameters" do

      let (:base_node) { SentenceBuilder::BaseNode.new(name) }
      let (:base_node_with_string) { SentenceBuilder::BaseNode.new(name_string) }

      it "gets name correctly" do
        expect(base_node).to respond_to('name')
        expect(base_node.name).to eq(name)
      end

      it "converts name parameter to symbol" do
        expect(base_node_with_string.name).to eq(name)
        expect(base_node.name).not_to eq(name_string)
      end

      it "sets default to nil" do
        expect(base_node.default).to eq(nil)
      end

      it "cannot set default" do
        expect(base_node).to respond_to('default')
      end

      it "sets prefix as empty string" do
        expect(base_node.prefix).to eq('')
      end

      it "sets suffix as empty string" do
        expect(base_node.suffix).to eq('')
      end
    end

    context "with extra parameters" do
      let(:prefix) { 'test_prefix' }
      let(:suffix) { 'test_suffix' }
      let(:default) { 'test_default' }
      let(:options) { { prefix: prefix, suffix: suffix } }
      let(:node) { SentenceBuilder::BaseNode.new(name, options) }

      it "sets prefix getter and setter" do
        expect(node).to respond_to('prefix')
        expect(node).to respond_to('prefix=')
      end

      it "sets suffix getter and setter" do
        expect(node).to respond_to('suffix')
        expect(node).to respond_to('suffix=')
      end

      it "sets prefix correctly" do
        expect(node.prefix).to eq(prefix)
        expect(node.prefix).not_to eq('random_prefix')
      end

      it "updates prefix" do
        node.prefix = 'new_prefix'
        expect(node.prefix).to eq('new_prefix')
        expect(node.prefix).not_to eq(prefix)
      end

      it "sets suffix correctly" do
        expect(node.suffix).to eq(suffix)
        expect(node.suffix).not_to eq('random_suffix')
      end

      it "updates suffix" do
        node.suffix = 'new_suffix'
        expect(node.suffix).to eq('new_suffix')
        expect(node.suffix).not_to eq(suffix)
      end
    end
  end
end
