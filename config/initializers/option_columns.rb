module OptionColumns
  def option_columns(*columns)
    columns.map(&:to_s).each do |column|
      define_method("#{column}_name") do
        self.class.const_get(column.pluralize.upcase)[send(column)]
      end

      self.class.send(:define_method, column.pluralize) do
        [].tap { |h| const_get(column.pluralize.upcase).each_with_index { |t, i| h << [t, i] } }
      end
    end
  end
end

ActiveRecord::Base.extend(OptionColumns)