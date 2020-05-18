require 'csv/output_generator'

RSpec.describe OutputGenerator, type: :module do
  context 'correct object definition' do
    it { is_expected.to be_a(Module) }
  end
end
