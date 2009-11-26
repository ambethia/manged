class Item < ActiveRecord::Base
  establish_connection :mangos
  set_table_name  :item_template
  set_primary_key :entry

  ICLASSES = [
    "Consumable", "Container", "Weapon",
    "Gem", "Armor", "Reagent",
    "Projectile", "Trade Goods", "Generic (OBSOLETE)",
    "Recipe", "Money (OBSOLETE)", "Quiver",
    "Quest", "Key", "Permanent (OBSOLETE)",
    "Miscellaneous", "Glyph"
  ]

  SUBCLASSES = [
    ["Consumable", "Potion", "Elixir", "Flask", "Scroll", "Food & Drink", "Item Enhancement", "Bandage", "Other"],
    ["Bag", "Soul Bag", "Herb Bag", "Enchanting Bag", "Engineering Bag", "Gem Bag", "Mining Bag", "Leatherworking Bag", "Inscription Bag"],
    ["Axe", "Axe", "Bow", "Gun", "Mace", "Mace", "Polearm", "Sword", "Sword", "Obsolete", "Staff", "Exotic", "Exotic", "Fist Weapon", "Miscellaneous", "Dagger", "Thrown", "Spear", "Crossbow", "Wand", "Fishing Pole"],
    ["Red", "Blue", "Yellow", "Purple", "Green", "Orange", "Meta", "Simple", "Prismatic"],
    ["Miscellaneous", "Cloth", "Leather", "Mail", "Plate", "Buckler (OBSOLETE)", "Shield", "Libram", "Idol", "Totem", "Sigil"],
    ["Reagent", "Wand (OBSOLETE)", "Bolt (OBSOLETE)", "Arrow", "Bullet", "Thrown (OBSOLETE)"],
    ["Trade Goods", "Parts", "Explosives", "Devices", "Jewelcrafting", "Cloth", "Leather", "Metal & Stone", "Meat", "Herb", "Elemental", "Other", "Enchanting", "Material", "Armor Enchantment", "Weapon Enchantment"],
    ["Generic (OBSOLETE)"],
    ["Book", "Leatherworking", "Tailoring", "Engineering", "Blacksmithing", "Cooking", "Alchemy", "First Aid", "Enchanting", "Fishing", "Jewelcrafting"],
    ["Money (OBSOLETE)"],
    ["Quiver (OBSOLETE)", "Quiver (OBSOLETE)", "Quiver", "Ammo Pouch"],
    ["Quest"],
    ["Key", "Lockpick"],
    ["Permanent"],
    ["Junk", "Reagent", "Pet", "Holiday", "Other", "Mount"],
    ["Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Death Knight", "Shaman", "Mage", "Warlock", "UNUSED", "Druid"]
  ]

  # alias_attribute :iclass, :class

  option_columns :iclass

  # Because `class` is a reserved column name, and it's in the schema.
  def self.instance_method_already_implemented?(method_name)
    return true if method_name == 'class'
    super
  end

  def iclass
    self[:class]
  end

  def iclass=(klass)
    self[:class] = klass
  end
end