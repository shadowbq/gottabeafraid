require 'rubygems'

require "socksify"
require "socksify/http"

require 'mechanize'
require "mechanize/agent"

require 'nokogiri'
require 'chronic'
require 'active_record'
require 'active_support'
require 'sqlite3'
require 'logger'

require 'tempfile'

require "gottabeafraid/version"
require "gottabeafraid/gonna"
require "gottabeafraid/Model/afraid"
require "gottabeafraid/gonna"

module Gottabeafraid 
  module DB
    
    #the database needs to be pre-raked migrated
    
    lib_path = File.expand_path("../", __FILE__)
    config_path = File.expand_path("../../db", __FILE__)
    
    begin
      log_path = File.expand_path("../../log", __FILE__)
      ActiveRecord::Base.logger = Logger.new("#{log_path}/debug.log")
    rescue Errno::ENOENT
      log_path = Dir.tmpdir
      ActiveRecord::Base.logger = Logger.new("#{log_path}/debug.log")
    rescue   
      ActiveRecord::Base.logger = ActiveSupport::BufferedLogger.new("/dev/null")
    end  
    
    ActiveRecord::Base.configurations = YAML::load(IO.read("#{config_path}/config.yml"))
    ActiveRecord::Base.establish_connection('development')
    
    class Controller
    
      def destroy
        Gottabeafraid::DB::Afraid.destroy_all
      end
    
    end
    
  end
end
