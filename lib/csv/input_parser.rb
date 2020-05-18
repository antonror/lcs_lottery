require 'optparse'
require 'csv'

module InputParser
  attr_accessor :file_name, :winning_number, :imported_csv

  def parse_options
    file_name, winning_number = String.new
    OptionParser.new do |parser|
      parser.on('-f file_name', '--file=file_name', '') do |option|
        file_name = option
      end
      parser.on('-w winning_number', '--winnumber=winning_number', '') do |option|
        winning_number = option
      end
    end.parse!

    if (file_name && winning_number).nil?
      raise StandardError, 'requires -f test.csv and -w 02141241241241 arguments'
    else
      update_properties(file_name, winning_number)
    end

  end

  def import_csv_file
    file_path = self.file_name || ''
    begin
      file =
        CSV.parse(File.join(File.read(file_name)), headers: false) unless file_path.empty?
    rescue => e
      return 'Failed to import CSV', e.message
    end

    update_imported_csv(file)
  end

  private

  def update_properties(file_name, winning_number)
    self.file_name = file_name
    self.winning_number = winning_number
  end

  def update_imported_csv(file)
    self.imported_csv = file
  end
end
