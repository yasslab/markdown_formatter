# MarkdownFormatter

Markdown formatter that removes unnecessary newlines, written in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'markdown_formatter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install markdown_formatter

## Usage

```
Usage: mdfmt [options] filepath
    -w, --overwrite                  overwrite file instead of stdout
    -v, --version                    display the version.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yasslab/markdown_formatter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

Copyright &copy; 2017 [YassLab](https://yasslab.jp)

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[![YassLab Logo](https://yasslab.jp/img/logo_800x200.png)](https://yasslab.jp/)
