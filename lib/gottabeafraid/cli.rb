require 'optparse'
$:.unshift(File.expand_path("../../", __FILE__))
require 'gottabeafraid'
require 'highline/import'

module Gottabeafraid
  class CLI

    options = {}
    options[:port] = 9050 # OSx uses 51900

    opt_parser = OptionParser.new do |opt|
      opt.banner = "Usage: #{__FILE__} COMMAND [OPTIONS]"
      opt.separator ""
      opt.separator "Onion / Tor"
        
      opt.on("-o","--onion","Run on onion/tor network via socks mode?") do
        options[:onion] = true
      end

      opt.on("-p", "--socks-port", "Socks 5 Proxy port for Tor", "Default: #{options[:port]}") do |v|
        options[:port] = v
      end 
      
      opt.separator "Options"

      opt.on("-t", "--[no-]test", "Run Test suite mocks") do |v|
        options[:test] = v
      end 
      
      opt.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end
      
      opt.on_tail("-h","--help","help") do
        puts opt_parser
        exit 0
      end
    end

    opt_parser.parse!

    if options[:test] 

      # Testing
      session = Gottabeafraid::Bin::Gonna.new
      puts "Inserting in database #{session.mocklisting(2)} Records"
      session = nil
     
    else
      
      username = ask("Enter your afraid.org username: ")
      password = ask("Enter your afraid.org password: ") {|q| q.echo = "*" }

      session = Gottabeafraid::Bin::Gonna.new
      
      if options[:onion]
        session.set_tor(options[:port])
        puts "Fetching Tor Exit IP"
        puts session.tor_check
        ensure_tor = ask("Are you protected? [No/Yes]")
        exit 1 if ensure_tor.downcase.strip != 'yes'
      end
      
      session.login(username, password)

      puts "Established session: #{session.show_session}"
      
      max = 912
      
      (1..max).to_a.each do |page|
        puts "Fetching page #{page} of #{max}" 
        puts "Inserting in database #{session.listing(page)} Records"
        sleep 1
      end

      session.logout
      session = nil

    end
  end
end