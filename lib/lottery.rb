require_relative 'csv/input_parser'
require_relative 'csv/output_generator'
require_relative 'lcs/credit_per_participant'


class Lottery
  extend InputParser
  extend OutputGenerator
  extend CreditPerParticipant

  def self.call
    parse_options
    import_csv_file
    calculate_scores
    export_csv_file
  end
end

Lottery.call
