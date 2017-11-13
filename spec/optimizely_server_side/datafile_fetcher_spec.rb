require 'spec_helper'

RSpec.describe OptimizelyServerSide::DatafileFetcher do

  describe '#fetch' do

    context 'when 200 response' do
      before do
        stub_request(:get, "https://cdn.optimizely.com/json/5960232316.json")
        .to_return(body: '{"experiments": [{"status": "running"}]}',status: 200)
      end

      it 'should fetch the config' do
        expect(described_class.fetch.content).to eq('{"experiments": [{"status": "running"}]}')
      end


      it 'should return stringified datafile' do
        expect(described_class.datafile.content).to eq('{"experiments": [{"status": "running"}]}')
      end

    end


    context 'when 500 response' do
      before do
        stub_request(:get, "https://cdn.optimizely.com/json/5960232316.json")
        .to_return(body: '{"experiments": [{"status": "running"}]}',status: 500)
      end

      it 'should fetch the config' do
        expect(described_class.fetch.content).to eq('{"experiments": [],"version": "2","audiences": [],"attributes": [],"groups": [],"projectId": "5960232316","accountId": "5955320306","events": [],"revision": "30"}')
      end


      it 'should return stringified datafile' do
        expect(described_class.datafile.content).to eq('{"experiments": [],"version": "2","audiences": [],"attributes": [],"groups": [],"projectId": "5960232316","accountId": "5955320306","events": [],"revision": "30"}')
      end

    end

  end

end
