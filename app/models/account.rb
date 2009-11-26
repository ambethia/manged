require 'digest/sha1'

class Account < ActiveRecord::Base
  establish_connection :realmd
  set_table_name :account

  EXPANSIONS = ['Classic', 'Burning Crusade', 'Wrath of the Lich King']
  GM_LEVELS   = ['Player', 'Moderator', 'Game Master', 'Administrator']

  alias_attribute :gm_level, :gmlevel

  option_columns :expansion, :gm_level

  attr_reader :password
  def password=(password)
    unless password.blank?
      hash = Digest::SHA1.hexdigest([username, password].map(&:upcase)*':')
      self.sha_pass_hash = hash
    end
  end
end

