require 'ostruct'
class Item < ActiveRecord::Base
  establish_connection :mangos
  set_table_name  :item_template
  set_primary_key :entry

  before_save :auto_increment_entry

  def auto_increment_entry
    unless entry && entry > 0
      self.entry = Item.last.entry + 1
    end
  end

  define_index do
    indexes name, :sortable => true
    indexes entry, :sortable => true
    indexes displayid, :sortable => true
    indexes description
  end

  # Used in search results
  def summary
    summary = '%s: %s (%s)' % [
      self.class.name,
      CLASSES[self[:class]],
      SUBCLASSES[self[:class]][subclass]
    ]
  end

  CLASSES = [
    "Consumable", "Container", "Weapon", "Gem", "Armor", "Reagent",
    "Projectile", "Trade Goods", "Generic (OBSOLETE)", "Recipe", "Money (OBSOLETE)",
    "Quiver", "Quest", "Key", "Permanent (OBSOLETE)", "Miscellaneous", "Glyph"]

  SUBCLASSES = [
    ["Consumable", "Potion", "Elixir", "Flask", "Scroll", "Food & Drink", "Item Enhancement", "Bandage", "Other"],
    ["Bag", "Soul Bag", "Herb Bag", "Enchanting Bag", "Engineering Bag", "Gem Bag", "Mining Bag", "Leatherworking Bag", "Inscription Bag"],
    ["1H Axe", "2H Axe", "Bow", "Gun", "1H Mace", "2H Mace", "Polearm", "1H Sword", "2H Sword", "Obsolete", "Staff", "Exotic", "Exotic", "Fist Weapon", "Miscellaneous", "Dagger", "Thrown", "Spear", "Crossbow", "Wand", "Fishing Pole"],
    ["Red", "Blue", "Yellow", "Purple", "Green", "Orange", "Meta", "Simple", "Prismatic"],
    ["Miscellaneous", "Cloth", "Leather", "Mail", "Plate", "Buckler (OBSOLETE)", "Shield", "Libram", "Idol", "Totem", "Sigil"],
    ["Reagent"],
    ["Wand (OBSOLETE)", "Bolt (OBSOLETE)", "Arrow", "Bullet", "Thrown (OBSOLETE)"],
    ["Trade Goods", "Parts", "Explosives", "Devices", "Jewelcrafting", "Cloth", "Leather", "Metal & Stone", "Meat", "Herb", "Elemental", "Other", "Enchanting", "Material", "Armor Enchantment", "Weapon Enchantment"],
    ["Generic (OBSOLETE)"],
    ["Book", "Leatherworking", "Tailoring", "Engineering", "Blacksmithing", "Cooking", "Alchemy", "First Aid", "Enchanting", "Fishing", "Jewelcrafting"],
    ["Money (OBSOLETE)"],
    ["Quiver (OBSOLETE)", "Quiver (OBSOLETE)", "Quiver", "Ammo Pouch"],
    ["Quest"],
    ["Key", "Lockpick"],
    ["Permanent"],
    ["Junk", "Reagent", "Pet", "Holiday", "Other", "Mount"],
    ["Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Death Knight", "Shaman", "Mage", "Warlock", "UNUSED", "Druid"]]

  QUALITIES = ["Poor", "Common", "Uncommon", "Rare", "Epic", "Legendary", "Artifact"]

  INVENTORY_TYPES = [
    "Non equipable", "Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist",
    "Legs", "Feet", "Wrists", "Hands", "Finger", "Trinket", "Weapon", "Shield",
    "Ranged", "Back", "Two-Hand", "Bag", "Tabard", "Robe", "Main hand",
    "Off hand", "Holdable (Tome)", "Ammo", "Thrown", "Ranged right", "Quiver", "Relic"]

  FLAGS = [
    ["Soulbound",                       :soulbound],
    ["Conjured",                        :conjured],
    ["Lootable ",                       :lootable],
    ["Wrapped",                         :wrapped],
    ["Deprecated; item no longer used", :deprecated],
    ["Totem",                           :totem],
    ["Activatable with right-click",    :activatable],
    ["",                                nil],
    ["Wrapper",                         :wrapper],
    ["Gifts",                           :gifts],
    ["Party lootable",                  :party_loot],
    ["",                                nil],
    ["",                                nil],
    ["Charter (Arena or Guild)",        :charter],
    ["",                                nil],
    ["PvP reward item",                 :pvp],
    ["",                                nil],
    ["",                                nil],
    ["",                                nil],
    ["Unique equipped",                 :unique_equip],
    ["",                                nil],
    ["",                                nil],
    ["Throwable",                       :throwable],
    ["Special Use",                     :special],
    ["",                                nil],
    ["",                                nil],
    ["",                                nil],
    ["Bind On Account",                 :bind_account],
    ["",                                nil],
    ["",                                nil],
    ["Millable",                        :millable]]

  FACTIONS = ["None", "Horde", "Alliance"]

  PLAYER_CLASSES = [
    ["Warrior",      :warrior],
    ["Paladin",      :paladin],
    ["Hunter",       :hunter],
    ["Rogue",        :rouge],
    ["Priest",       :priest],
    ["Death Knight", :death_knight],
    ["Shaman",       :shaman],
    ["Mage",         :mage],
    ["Warlock",      :warlock],
    ["",             :null],
    ["Druid",        :druid]]

  PLAYER_RACES = [
    ["Human",     :human],
    ["Orc",       :orc],
    ["Dwarf",     :dwarf],
    ["Night Elf", :night_elf],
    ["Undead",    :undead],
    ["Tauren",    :tauren],
    ["Gnome",     :gnome],
    ["Troll",     :troll],
    ["Blood Elf", :blood_elf],
    ["Draenei",   :draenei]]

  REQUIRED_SKILLS = {
    ''               => 0,
    'First Aid'      => 129,
    'Blacksmithing'  => 164,
    'Leatherworking' => 165,
    'Alchemy'        => 171,
    'Herbalism'      => 182,
    'Cooking'        => 185,
    'Mining'         => 186,
    'Tailoring'      => 197,
    'Engineering'    => 202,
    'Enchanting'     => 333,
    'Fishing'        => 356,
    'Jewelcrafting'  => 755,
    'Riding'         => 762,
    'Inscription'    => 773}

  REPUTATION_RANKS = ["", "Hated", "Hostile", "Unfriendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted" ]

  STATS = {
    "Mana"                     => 0,
    "Health"                   => 1,
    "Agility"                  => 3,
    "Strength"                 => 4,
    "Intellect"                => 5,
    "Spirit"                   => 6,
    "Stamina"                  => 7,
    "Defense Skill Rating"     => 12,
    "Dodge Rating"             => 13,
    "Parry Rating"             => 14,
    "Block Rating"             => 15,
    "Hit Melee Rating"         => 16,
    "Hit Ranged Rating"        => 17,
    "Hit Spell Rating"         => 18,
    "Crit Melee Rating"        => 19,
    "Crit Ranged Rating"       => 20,
    "Crit Spell Rating"        => 21,
    "Hit Taken Melee Rating"   => 22,
    "Hit Taken Ranged Rating"  => 23,
    "Hit Taken Spell Rating"   => 24,
    "Crit Taken Melee Rating"  => 25,
    "Crit Taken Ranged Rating" => 26,
    "Crit Taken Spell Rating"  => 27,
    "Haste Melee Rating"       => 28,
    "Haste Ranged Rating"      => 29,
    "Haste Spell Rating"       => 30,
    "Hit Rating"               => 31,
    "Crit Rating"              => 32,
    "Hit Taken Rating"         => 33,
    "Crit Taken Rating"        => 34,
    "Resilience Rating"        => 35,
    "Haste Rating"             => 36,
    "Expertise Rating"         => 37,
    "Attack Power"             => 38,
    "Ranged Attack Power"      => 39,
    "Feral Attack Powe"        => 40,
    "Spell Healing Done"       => 41,
    "Spell Damage Done"        => 42,
    "Mana Regeneration"        => 43,
    "Armor Penetration Rating" => 44,
    "Spell Power"              => 45,
    "Health Regen"             => 46,
    "Spell Penetration"        => 47,
    "Block Value"              => 48}

  # For simple mapping of options for select helpers
  option_columns :quality, :inventory_type, :factions, :reputation_ranks

  bitmask :Flags,          :as => FLAGS.map(&:last)
  bitmask :AllowableClass, :as => PLAYER_CLASSES.map(&:last)
  bitmask :AllowableRace,  :as => PLAYER_RACES.map(&:last)

  def special_bitmask_columns_on_write
    # DB expects the value to be -1 for "all"
    self[:AllowableClass] = -1 if self[:AllowableClass] == 0
    self[:AllowableRace]  = -1 if self[:AllowableRace]  == 0
  end

  before_save :special_bitmask_columns_on_write

  def klass=(klass)
    self[:class], self[:subclass] = klass.split '.'
  end

  def klass
    [self[:class], self[:subclass]] * '.'
  end

  # Because `class` is a reserved column name, and it's in the schema.
  def self.instance_method_already_implemented?(method_name)
    return true if method_name == 'class'
    super
  end

end
