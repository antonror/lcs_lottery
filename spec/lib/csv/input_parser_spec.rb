require 'csv/input_parser'

RSpec.describe InputParser, type: :service do
  it 'test' do
    expect(InputParser::TEST).to eq('TEST')
  end
end
