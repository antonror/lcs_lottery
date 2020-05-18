require 'csv'
require 'active_support/all'

module OutputGenerator
  attr_accessor :pre_indexed_csv, :result_file, :stdout_string

  class BasicValidator < Struct.new(:calculated_csv)
    def valid?
      random_row = self.calculated_csv.sample
      self.calculated_csv.is_a?(Array) &&
      self.calculated_csv.each{ |row| row.length == random_row.length } ?
        true : false
    end
  end

  def export_csv_file
    if BasicValidator.new(self.calculated_csv).valid?
      sort_table
      delete_losers
      match_duplicates
      generate_result_file
      generate_result_output
    else
      raise StandardError.new 'Please check your CSV file for consistency'
    end
  end

  def sort_table
    self.calculated_csv.sort_by{ |row| [row.first, row.third] }
  end

  def delete_losers
    self.calculated_csv.delete_if { |row| row.last.to_i.zero? }
  end

  def match_duplicates
    self.pre_indexed_csv = self.calculated_csv.deep_dup

    duplicates = {}

    self.pre_indexed_csv.each{ |row| row.delete(row.last) }.
      each_with_index{ |value, index| (duplicates[value] ||= []) << index }

    duplicates.delete_if{ |_, v| v.size == 1 }

    result = 0

    duplicates.each do |_, indexes|
      indexes.each do |index|
        result += self.calculated_csv[index].last.to_i
      end

      indexes.from(1).each do |index|
        self.calculated_csv.delete_at(index)
      end

      self.calculated_csv[indexes.first].pop
      self.calculated_csv[indexes.first].push(result)
    end
  end

  def generate_result_file
    self.result_file = CSV.generate { |csv| self.calculated_csv.each do |row| csv << row end }
    File.open('../result.csv', 'w') { |file| file.write(self.result_file) }
  end

  def generate_result_output
    self.result_file.split("\n").each do |row|
      p row
    end
  end
end
