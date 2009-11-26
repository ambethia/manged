require 'ostruct'
class Item < ActiveRecord::Base
  establish_connection :mangos
  set_table_name  :item_template
  set_primary_key :entry

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

  option_columns :quality, :inventory_type

  alias_attribute :quality,        :Quality
  alias_attribute :inventory_type, :InventoryType
  alias_attribute :flags,          :Flags

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
