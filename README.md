# SentenceBuilder

This gem is still under development. The documentation and tests will be ready soon.

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

## Contributing

1. Fork it ( https://github.com/eminbugrasaral/sentence-builder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
