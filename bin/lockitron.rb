require 'rubygems'
require 'thor'
require '../lib/api.rb'

class Lockitron < Thor

  desc 'lock LOCK_NAME', 'locks one of the available locks by name'
  def lock(name)
    API.lock_by_name(name)
  end

  desc 'unlock LOCK_NAME', 'unlocks one of the available locks by name'
  def unlock(name)
    API.unlock_by_name(name)
  end

  desc 'list', "list all of the available locks"
  def list
    API.available_locks
  end

end

Lockitron.start