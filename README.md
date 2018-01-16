# Trigger::Task

Create a very simple template to generate reminders on Slack.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trigger-task'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trigger-task

## Usage

I created it as a POC to solve my issues around generate reminders for every
newcomer starting in the company. I help them on the onboarding and I have a
few recurring tasks with each of them.

### Setup a template

This tool allow you to set a template with basic tasks you need to do based in
something. Let's say, I'd like to onboard a newcomer in my company, then I
create a simple file named `newcomer.txt` with the following content:

```
invite %s to slack at one day before
add %s to our team at today
pair programming with %s at next day
```

### Load template with date

Then I can run:

```
$ bin/trigger-task newcomer.txt @someone 'in two weeks'                                                                                          19:19:43
```

Considering I ran it in 01/16/2018, "today" will be in "two weeks"
and it will reproduce the following output:

```
/remind me to invite @someone to slack on 01/29/2018
/remind me to add @someone to our team on 01/30/2018
/remind me to pair programming with @someone on 01/31/2018
```

I'm just copying and pasting each reminder until I refine the idea and
integrate with Slack properly.

It uses [chronic](https://github.com/mojombo/chronic) to parse the date.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jonatas/trigger-task. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Trigger::Task project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/trigger-task/blob/master/CODE_OF_CONDUCT.md).
