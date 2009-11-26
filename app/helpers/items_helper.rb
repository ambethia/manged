module ItemsHelper
  def options_for_item_klass(selected)
    klasses = []
    Item::CLASSES.each_with_index do |klass, i|
      subklasses = []
      Item::SUBCLASSES[i].each_with_index do |subklass, j|
        subklasses << [subklass, [i,j]*'.']
      end
      klasses << [klass, subklasses]
    end
    grouped_options_for_select(klasses, selected)
  end
end