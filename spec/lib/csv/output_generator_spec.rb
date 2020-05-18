require 'csv/output_generator'

RSpec.describe OutputGenerator, type: :service do
  it 'test' do
    expect(OutputGenerator::TEST).to eq('TEST')
  end
end
