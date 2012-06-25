require 'bundler'
Bundler.require

class Lockitron

  DOMAIN = "https://api.lockitron.com"
  LOCKS_URL = DOMAIN + "/v1/locks"
  SETTINGS_PATH = './settings'

  def self.access_token
    @@access_token ||= load_access_token_from_settings
    request_access_token! if @@access_token == "" || @@access_token.nil?
    @@access_token
  end

  def self.load_access_token_from_settings
    File.read(SETTINGS_PATH) if File.exists?(SETTINGS_PATH)
  end

  def self.access_token=(token)
    @@access_token = token
    File.write(SETTINGS_PATH, token)
  end

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

  def self.request_access_token!
    puts "I need your access token to work. Head over to \"https://api.lockitron.com/v1/oauth/applications\" to get it."
    print "\nAccess Token: "
    access_token = $stdin.gets.chomp!
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

  def self.invalid_access_token!
    puts "Invalid Access Token... Try again!\n\n"
    request_access_token!
  end

  def self.available_locks
    access_token # Ensures that an access token has been selected
    puts "Available locks:\n\n"
    locks.each { |lock| puts lock['lock']['name'] }
  end

end