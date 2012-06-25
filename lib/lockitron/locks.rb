require 'rubygems'
require 'rest-client'
require 'json'
require 'lockitron/authentication'

module Lockitron
  class Locks
    extend Lockitron::Authentication

    def self.all
      url = "#{LOCKS_URL}?access_token=#{access_token}"
       @@locks ||= RestClient.get url do |response, request, result|
        if response.code == 200
          JSON.parse(response.to_str)
        elsif response.code == 401
          invalid_access_token!
        else
          puts "An unknown error occurred. Please send an email to jarred@lockitron.com and tell him what happened."
        end
      end
    end

    def self.names
      @@names ||= all.collect { |lock| lock['lock']['name'] }
    end

    def self.unlock(name)
      @@lock = find(name)
      access(@@lock, "unlock")
    end

    def self.lock(name)
      @@lock = find(name)
      access(@@lock, "lock")
    end

    def self.access(lock, direction)
      url = "#{LOCKS_URL}/#{lock['id']}/#{direction}"
      RestClient.post url, :access_token => access_token do |response|
        if response.code == 200
          puts "Successfully #{direction.capitalize}ed #{lock['name'].capitalize}!"
        elsif response.code == 401
          invalid_access_token!
        else
          puts "An unknown error ocurred. Please send an email to jarred@lockitron.com and tell him what happened."
        end
      end
    end

    def self.find(name)
      @@lock = all.select { |lock| lock['lock']['name'] == name }
      if @@lock.empty?
        puts "No available lock named #{name}\n\n"
        list
      else
        return @@lock.first["lock"]
      end
    end

    def self.list
      access_token # Ensures that an access token has been selected
      puts "Available locks:\n"
      all.each { |lock| puts lock['lock']['name'] }
    end
  end
end