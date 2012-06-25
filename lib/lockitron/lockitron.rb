module Lockitron
  class Locks
    extend Lockitron::Authentication
    DOMAIN = "https://api.lockitron.com"
    LOCKS_URL = DOMAIN + "/v1/locks"
    SETTINGS_PATH = './settings'

    def self.locks
      url = "#{LOCKS_URL}?access_token=#{access_token}"
       @@locks ||= RestClient.get url do |response, request, result|
        if response.code == 200
          JSON.parse(response.to_str)
        elsif response.code == 401
          invalid_access_token!
          self.locks
        else
          puts "Something went wrong, and I'm not sure what. Please send an email to jarred@lockitron.com and tell him what happened."
        end
      end
    end

    def self.lock_names
      @@names ||= locks.collect { |lock| lock['lock']['name'] }
    end

    def self.unlock_by_name(name)
      @@lock = find_lock_by_name(name)
      access_lock(@@lock, "unlock")
    end

    def self.lock_by_name(name)
      @@lock = find_lock_by_name(name)
      access_lock(@@lock, "lock")
    end

    def self.access_lock(lock, direction)
      url = "#{LOCKS_URL}/#{lock['id']}/#{direction}"
      RestClient.post url, :access_token => access_token do |response|
        if response.code == 200
          puts "Successfully #{direction.capitalize}ed #{lock['name'].capitalize}!"
        elsif response.code == 401
          invalid_access_token!
          access_lock(lock,direction)
        else
          puts "Something went wrong, and I'm not sure what. Please send an email to jarred@lockitron.com and tell him what happened."
        end
      end
    end

    def self.find_lock_by_name(name)
      @@lock = locks.select { |lock| lock['lock']['name'] == name }
      if @@lock.empty?
        puts "No available lock named #{name}\n\n"
        available_locks
        exit
      else
        return @@lock.first["lock"]
      end
    end

    def self.available_locks
      access_token # Ensures that an access token has been selected
      puts "Available locks:\n\n"
      locks.each { |lock| puts lock['lock']['name'] }
    end
  end
end