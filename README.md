# BloomPublic

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bloom_public'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bloom_public

## Usage

If you have a secret key, configure it like this:

    BloomPublic.configure { |c| c.secret = 'your_secret' }

Getting a list of sources:

    BloomPublic.sources

    [{"source"=>"usgov.hhs.icd_10_gems", "updated"=>"2016-01-01T05:08:58.607096Z", "checked"=>"2016-06-22T04:47:45.221297Z", "status"=>"READY"} ....

Find an object by id for a given source:

    BloomPublic.get_by_id(source: 'usgov.hhs.pecos', id: '1932494937')

    {"npi"=>1932494937.0, "pecos"=>true, "pending_review"=>false, "pmd"=>true}

Searching with filters:

    filter = BloomPublic::Filter.new(key: 'npi', op: 'eq', value: '1720017569')
    BloomPublic.search(source: 'usgov.hhs.pecos', filters: [filter]))

    [{"npi"=>1720017569.0, "pecos"=>false, "pending_review"=>false, "pmd"=>false}]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adhocteam/bloom_public.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
