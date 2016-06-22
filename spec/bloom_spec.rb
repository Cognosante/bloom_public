require 'spec_helper'

describe BloomPublic do
  it 'has a version number' do
    expect(BloomPublic::VERSION).not_to be nil
  end

  it 'lets me configure it' do
    expect(BloomPublic.configure).to be_an_instance_of(BloomPublic::Configuration)
  end

  it 'returns the configuration' do
    expect(BloomPublic.configuration).to be_an_instance_of(BloomPublic::Configuration)
  end

  it 'lets me set the API key' do
    BloomPublic.configure do |config|
      config.secret = 'abc-123'
    end
    expect(BloomPublic.configuration.secret).to eq('abc-123')
  end

  context 'with a secret' do
    before do
      BloomPublic.configure do |config|
        config.secret = ''
      end
    end

    it 'should give me a list of sources' do
      expect(BloomPublic.sources).to be_an_instance_of(BloomPublic::Response)
    end

    it 'should give me an item by id' do
      expect(BloomPublic.get_by_id(source: 'usgov.hhs.pecos', id: '1932494937')).to be_an_instance_of(BloomPublic::Response)
    end

    it 'should let me search' do
      expect(BloomPublic.search(source: 'usgov.hhs.pecos')).to be_an_instance_of(BloomPublic::Response)
    end

    it 'should let me search with a filter' do
      filter = BloomPublic::Filter.new(key: 'npi', op: 'eq', value: '1720017569')
      expect(BloomPublic.search(source: 'usgov.hhs.pecos', filters: [filter])).to be_an_instance_of(BloomPublic::Response)
    end
  end
end
