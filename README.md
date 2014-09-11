# Gotta Be Afraid

Be afraid, be very afraid of afraid.org. Stare into the abyss for too long and you'll burn out your eyes!

## Installation

Add this line to your application's Gemfile:

    gem 'gottabeafraid'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gottabeafraid

## Usage

You know.. be afraid. 

```shell
$ ./bin/gonna --help
Usage: /home/user/sandbox/github/gottabeafraid/lib/gottabeafraid/cli.rb COMMAND [OPTIONS]

Onion / Tor
    -o, --onion                      Run on onion/tor network via socks mode?
    -p, --socks-port                 Socks 5 Proxy port for Tor
                                     Default: 9050
Options
    -t, --[no-]test                  Run Test suite mocks
    -v, --[no-]verbose               Run verbosely
    -h, --help                       help

```

Just run irb, silly..

## Using Tor/Onion

When Onion flag is enabled it will attempt to use a Socks Proxy on 51400 to connect to afraid.org. Note the SSL certificate verification is disabled when doing this. 

```ruby
@agent.agent.set_socks('127.0.0.1', 51400)
@agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
```

It will also attempt to perform a sanity check on your new Tor node IP address.



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT - See [LICENSE](./LICENSE) for details.

Copyright 2014 Shadowbq 
