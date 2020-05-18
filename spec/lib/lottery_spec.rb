require 'lottery'

RSpec.describe Lottery, type: :service do
  it 'test' do
    expect(Lottery::TEST).to eq('TEST')
  end
end