DOMAIN = "https://api.lockitron.com"
LOCKS_URL = DOMAIN + "/v1/locks"

module Lockitron
  module Authentication

    def access_token
      @@access_token ||= ENV["LOCKITRON_ACCESS_TOKEN"]
      invalid_access_token! if @@access_token == "" || @@access_token.nil?
      @@access_token
    end

    def access_token=(token)
      @@access_token = token
    end
    
    def invalid_access_token!
      puts "Invalid Access Token!"
      puts "I need a valid access token stored in the environment variable LOCKITRON_ACCESS_TOKEN. Head over to \"https://api.lockitron.com/v1/oauth/applications\" to get an access token."
      puts "Once you have an access token, run \"export LOCKITRON_ACCESS_TOKEN=ACCESS_TOKEN\", where ACCESS_TOKEN is your access token."
      puts "Store the access token as an environment variable in ~/.bashrc if you don't want to have to do this everytime"
      exit
    end

  end
end
