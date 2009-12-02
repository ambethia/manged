class Realm < ActiveRecord::Base
  establish_connection :realmd
  set_table_name :realmlist

  has_many :uptimes, :foreign_key => :realmid

  def uptime
    uptimes.first :order => '`startstring` DESC'
  end

  class Uptime < ActiveRecord::Base
    establish_connection :realmd
    set_table_name :uptime
    set_primary_key :starttime
    belongs_to :realm, :foreign_key => 'realmid'

    def start_time
      startstring.to_time
    end

    def duration
      Time.now - start_time
    end
  end
end

