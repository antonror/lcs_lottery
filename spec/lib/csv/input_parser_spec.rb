require 'csv/input_parser'

RSpec.describe InputParser, type: :module do
  context 'correct object definition' do
    it { is_expected.to be_a(Module) }
  end
end
