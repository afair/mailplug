# Mailplug

An Email Processing Framework for Ruby

    Mailplug is in development currently. It is unlikely to do anything
    useful at this time. Thoughtful contributions are welcome!

`Mailplug is a mini-framework for processing email. It can accept email via SMTP or other sources, perform various checks, and queue it through your MTA (Mail Transfer Agent) such as Postfix, Qmail, Sendmail, etc. It relies on the middleware pattern to build up a set of services for your email processor.

Features (will) include:

- Accepting mail from a remote SMTP Server.
- Providing various validation services for incoming email
- Saving the message to a MTA, Message Queue, or relaying it elsewhere
- Delivery to applications via HTTP
- Adding Headers, tags, and signing messages
- Logging
- Filtering
- Delivery Processing like "Procmail"

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mailplug'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mailplug

## Usage

Use the `mailplug` command to control it from the command line or
scripts. It can run as a standalone server, on a per-request basis
(triggered by inetd, tcpserver, or similar controls),


    mailplug smtp [--port=25] [--config=~/.mailplug] [--daemon]
             maildir [path]
             maibox [filename]
             procmail [configfile]
             inetd
             message return_path recipients ... < message_data

Or run it through `inetd` or `tcpserver`

    /usr/local/bin/tcpserver -4 -v -R -H -c 250 -g 82 -u 85 -l example.com 0 25 /usr/local/bin/mailplug inetd

    smtp    stream  tcp nowait  root  /usr/local/bin/mailplug inetd

Or integrate it in your application and call

    Mailplug.message(data, mail_from, rcpt_to)


## Configuration

The following modules are available to build your processor

- SMTP (Accept mail via SMTP)
- DKIM-Check
- SPF-Check
- SRS-BATV
- Sender-XXX
- Recipient-XXX
- SpamAssassin (Spam Checker)
- ClamAV (Virus Scanner)
- Qmail-Queue (Qmail MTA)
- Qmail-QMQP
- Postfix-Queue
- HTTP-Delivery

... or write your own! It's easy to follow the middleware pattern! Create your configuration in  `~/.mailplug`, `/etc/mailplug` or `/usr/local/etc/mailplug` and start it up. Copy a skeleton plugin from `lib/mailplug/plugin/example.rb`

    #!/usr/bin/env ruby
    load "my_plugin.rb"
    Mailplug.stack do
      plugin RemoteBlacklist, config:"value"
      plugin MyPlugin, mode: "live"
    end


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mailplug. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

