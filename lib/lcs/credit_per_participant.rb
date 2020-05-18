require 'diff-lcs'

module CreditPerParticipant
  attr_accessor :calculated_csv

  def calculate_scores
    csv_table = self.imported_csv
    winning_number = self.winning_number

    csv_table.each do |row|
      user_number = row.last
      score = Diff::LCS.LCS(winning_number, user_number).join.length
      row.delete(user_number)
      row << score
    end

    update_lottery_attributes(csv_table)
  end

  private

  def update_lottery_attributes(csv_table)
    self.calculated_csv = csv_table
  end
end
