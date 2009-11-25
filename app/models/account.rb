require 'digest/sha1'

class Account < ActiveRecord::Base
  establish_connection :realmd
  set_table_name :account

  EXPANSIONS = ['Classic', 'Burning Crusade', 'Wrath of the Lich King']
  GM_LEVELS  = ['Player', 'Moderator', 'Game Master', 'Administrator']

  def self.gm_levels
    [].tap{ |h| GM_LEVELS.each_with_index { |t, i| h << [t, i] } }
  end

  def self.expansions
    [].tap{ |h| EXPANSIONS.each_with_index { |t, i| h << [t, i] } }
  end

  def gm_level_name
    GM_LEVELS[gmlevel]
  end

  def expansion_name
    EXPANSIONS[expansion]
  end

  attr_reader :password
  def password=(password)
    unless password.blank?
      hash = Digest::SHA1.hexdigest([username, password].map(&:upcase)*':')
      self.sha_pass_hash = hash
    end
  end
end

