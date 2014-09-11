module Gottabeafraid
  module Bin

    class Gonna

      attr_accessor :agent

      def initialize(verbose=false)
        # Create a new mechanize object
        if verbose 
          @agent = Mechanize.new { |a| a.log = Logger.new(STDERR) }
        else
          @agent = Mechanize.new 
        end  

        @agent.user_agent_alias = 'Windows Mozilla'
        @agent.keep_alive = 'enable'
      end
      
      def set_tor(socks_port)
        #Tor Enabled
        @agent.agent.set_socks('127.0.0.1', socks_port)
        @agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      
      def tor_check
        external_ip
      end
      
      def login(username, password)
        page = @agent.get('https://freedns.afraid.org/zc.php')

        form = page.forms[0] # Select the first form
        form["username"] = username
        form["password"] = password
        form["from"] = "L21lbnUv"
        form["action"] = "auth"
        form["remote"] = ""
        form["submit"] = "Login"
    
        # Submit the form
        page = form.submit 
      end
  
      def listing(q)
        page = @agent.get("https://freedns.afraid.org/domain/registry/page-#{q}.html")
        parseit(page.body)
      end
  
      def mocklisting(q)
        page = @agent.get("http://localhost:4567/page-#{q}.html")
        parseit(page.body)
      end
  
      def show_session
        @agent.agent.cookie_jar.jar["freedns.afraid.org"]["/"]["dns_cookie"].value
      end
      
      def logout
        page = @agent.get('https://freedns.afraid.org/logout/')
        @agent = nil
      end
  

      private 

      def external_ip
        res = @agent.get("http://checkip.dyndns.org")
        return res.body.match('Current IP Address: ([0-9\.]*).*')[1]
      end

      def parseit(body)
        fragment = Nokogiri::HTML(body)
        ["//tr[@class='trd']", "//tr[@class='trl']"].each do |xpathq|
          fragment.xpath(xpathq).each do |match|
            createrecord(match) 
          end
        end
        
        Gottabeafraid::DB::Afraid.count   
      end

      def createrecord(match)

        record = Hash.new
        record[:domain_name] = match.children[0].xpath('.//a')[0].children[0].to_s
        hosts = match.children[0].xpath('.//span')[0].children[0].to_s
        record[:hosts] = /[0-9]+/.match(hosts).to_s.to_i
        record[:security] = match.children[1].children[0].to_s
        record[:user] = match.children[2].xpath('.//a')[0].children[0].to_s
        age = match.children[3].children[0].to_s
        record[:age] = Chronic.parse(/\(([0-9\/]+)\)/.match(age)[1])
    
        Gottabeafraid::DB::Afraid.create(record)

      end

    end #Class

  end
end
