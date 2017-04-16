[![Stories in Ready](https://badge.waffle.io/eminbugrasaral/sentence-builder.png?label=ready&title=Ready)](https://waffle.io/eminbugrasaral/sentence-builder)
# SentenceBuilder

[![Gem Version](https://badge.fury.io/rb/sentence_builder.svg)](http://badge.fury.io/rb/sentence_builder)
[![Code Climate](https://codeclimate.com/github/eminbugrasaral/sentence-builder/badges/gpa.svg)](https://codeclimate.com/github/eminbugrasaral/sentence-builder)
[![Build Status](https://travis-ci.org/ebsaral/sentence-builder.svg?branch=master)](https://travis-ci.org/ebsaral/sentence-builder)
[![Stories in Ready](https://badge.waffle.io/eminbugrasaral/sentence-builder.png?label=ready&title=Ready)](https://waffle.io/eminbugrasaral/sentence-builder)

Dynamic sentence (or text) builder helps to create your sentence nodes with many options and then automatically generates your sentence or constructs the hash array of your sentence nodes for any later use.

NOTE: The documentation and tests will be ready soon.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sentence_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sentence_builder

## Usage

Simple example

```ruby
node1 = SentenceBuilder::SentenceNode.new(:title, prefix: 'With title', default: 'LalaLand')
node2 = SentenceBuilder::SentenceNode.new(:year, prefix: 'at', default: '2013', always_use: false)

builder = SentenceBuilder::Builder.new([node1, node2])

builder.get_sentence()  # With title LalaLand
builder.get_sentence({title: 'SentenceLand'})  # With title SentenceLand
builder.get_sentence({title: 'Emin Land', year: '2016'})  # With title Emin Land at 2016


```

Option matching example

```ruby
options = [{name: 'Apple', value: 1}, {name: 'Cherry', value: 2}]
node = SentenceBuilder::SentenceNode.new(:fruit,
                                         default: 2,
                                         prefix: "Let's eat",
                                         options: options)

builder = SentenceBuilder::Builder.new([node])

# Default was set to 2
builder.get_sentence  # Let's eat 2
builder.get_sentence({fruit: 1})  # Let's eat 1

# We may not be able to eat a fruit named 2. Let's get sexy:
node.match_with_options = true
builder.get_sentence  # Let's eat Cherry
builder.get_sentence({fruit: 1})  # Let's eat Apple

# Note: If you want match_with_options to work, the structure of options hash be like:
# {name: 'Display', value: 1}
# {name: 'Display', value: 1, foo: bar}

# Note II: Cannot replace the node with the options if the value does not exist :/
builder.get_sentence({fruit: 'Kiwi'})  # Let's eat Kiwi

```

## TODOs

- Write a proper & detailed documentation with examples
- Cover all tests
- Add parameter protection / validation
- Add / improve errors within the code structure
- Add "creating nodes from YAML" feature into the builder for lazy or practical people
- Create an example app
- Tell your girlfriend you love her when the time comes


## Contributing

1. Fork it ( https://github.com/eminbugrasaral/sentence-builder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
