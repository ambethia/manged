class Character < ActiveRecord::Base
  establish_connection :characters
  set_primary_key :guid

  named_scope :online, :conditions => { :online => true }

  def klass
    self[:class]
  end

  def class
    Character
  end

  belongs_to :account, :foreign_key => 'account'
end

